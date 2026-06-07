#!/usr/bin/env python3
"""Inventory C# solution and project metadata for tutoring/review context."""

from __future__ import annotations

import argparse
import json
import sys
import xml.etree.ElementTree as ET
from pathlib import Path


SKIP_DIRS = {
    ".git",
    ".vs",
    ".vscode",
    "bin",
    "obj",
    "node_modules",
    "packages",
}

KNOWN_TEST_PACKAGES = {
    "Microsoft.NET.Test.Sdk",
    "xunit",
    "xunit.v3",
    "xunit.runner.visualstudio",
    "NUnit",
    "NUnit3TestAdapter",
    "MSTest.TestAdapter",
    "MSTest.TestFramework",
}

KNOWN_ANALYZER_PACKAGES = {
    "Microsoft.CodeAnalysis.NetAnalyzers",
    "Roslynator.Analyzers",
    "SonarAnalyzer.CSharp",
    "StyleCop.Analyzers",
}


def iter_files(root: Path, patterns: tuple[str, ...]) -> list[Path]:
    results: list[Path] = []
    for path in root.rglob("*"):
        if not path.is_file():
            continue
        if any(part in SKIP_DIRS for part in path.relative_to(root).parts[:-1]):
            continue
        if any(path.match(pattern) for pattern in patterns):
            results.append(path)
    return sorted(results)


def read_xml(path: Path) -> ET.Element | None:
    try:
        return ET.parse(path).getroot()
    except ET.ParseError:
        return None


def element_name(element: ET.Element) -> str:
    return element.tag.rsplit("}", 1)[-1]


def find_all(parent: ET.Element, name: str) -> list[ET.Element]:
    return [element for element in parent.iter() if element_name(element) == name]


def find_first(parent: ET.Element, name: str) -> ET.Element | None:
    for element in parent.iter():
        if element_name(element) == name:
            return element
    return None


def text_of(parent: ET.Element, name: str) -> str | None:
    element = find_first(parent, name)
    if element is None or element.text is None:
        return None
    value = element.text.strip()
    return value or None


def all_text(parent: ET.Element, name: str) -> list[str]:
    values: list[str] = []
    for element in find_all(parent, name):
        if element.text and element.text.strip():
            values.append(element.text.strip())
    return values


def split_msbuild_list(values: list[str]) -> list[str]:
    results: list[str] = []
    for value in values:
        for item in value.split(";"):
            item = item.strip()
            if item:
                results.append(item)
    return results


def package_refs(
    parent: ET.Element,
    central_versions: dict[str, str] | None = None,
) -> list[dict[str, str | None]]:
    refs: list[dict[str, str | None]] = []
    central_versions = central_versions or {}
    for element in find_all(parent, "PackageReference"):
        include = element.attrib.get("Include") or element.attrib.get("Update")
        version = element.attrib.get("Version")
        if version is None:
            version_node = find_first(element, "Version")
            version = version_node.text.strip() if version_node is not None and version_node.text else None
        if include:
            version_source = "project" if version else None
            if version is None and include in central_versions:
                version = central_versions[include]
                version_source = "central"
            refs.append({"name": include, "version": version, "version_source": version_source})
    return sorted(refs, key=lambda item: item["name"] or "")


def project_refs(parent: ET.Element, project_path: Path, root: Path) -> list[dict[str, str]]:
    refs: list[dict[str, str]] = []
    for element in find_all(parent, "ProjectReference"):
        include = element.attrib.get("Include")
        if not include:
            continue
        resolved = (project_path.parent / include).resolve()
        try:
            resolved_relative = str(resolved.relative_to(root))
        except ValueError:
            resolved_relative = str(resolved)
        refs.append({"include": include, "path": resolved_relative})
    return sorted(refs, key=lambda item: item["path"])


def analyzer_refs(parent: ET.Element, packages: list[dict[str, str | None]]) -> list[dict[str, str | None]]:
    analyzers: list[dict[str, str | None]] = []
    for package in packages:
        name = package.get("name")
        if isinstance(name, str) and (name in KNOWN_ANALYZER_PACKAGES or name.endswith(".Analyzers")):
            analyzers.append({"type": "package", "name": name, "version": package.get("version")})

    for element in find_all(parent, "Analyzer"):
        include = element.attrib.get("Include")
        if include:
            analyzers.append({"type": "item", "include": include})

    return sorted(analyzers, key=lambda item: str(item.get("name") or item.get("include") or ""))


def central_package_versions(path: Path) -> dict[str, str]:
    xml = read_xml(path)
    if xml is None:
        return {}

    versions: dict[str, str] = {}
    for element in find_all(xml, "PackageVersion"):
        include = element.attrib.get("Include") or element.attrib.get("Update")
        version = element.attrib.get("Version")
        if version is None:
            version_node = find_first(element, "Version")
            version = version_node.text.strip() if version_node is not None and version_node.text else None
        if include and version:
            versions[include] = version
    return dict(sorted(versions.items()))


def central_versions_for_project(project_path: Path, central_package_files: list[Path]) -> dict[str, str]:
    candidates = [
        file
        for file in central_package_files
        if file.parent == project_path.parent or file.parent in project_path.parents
    ]
    if not candidates:
        return {}

    nearest = max(candidates, key=lambda file: len(file.parts))
    return central_package_versions(nearest)


def project_info(
    path: Path,
    root: Path,
    central_package_files: list[Path],
) -> dict[str, object]:
    xml = read_xml(path)
    if xml is None:
        return {"path": str(path.relative_to(root)), "parse_error": True}

    target_frameworks = split_msbuild_list(all_text(xml, "TargetFramework") + all_text(xml, "TargetFrameworks"))
    central_versions = central_versions_for_project(path, central_package_files)
    packages = package_refs(xml, central_versions)
    package_names = {str(pkg["name"]) for pkg in packages}
    file_name = path.name.lower()
    relative_parts = path.relative_to(root).parts
    is_test_project_property = (text_of(xml, "IsTestProject") or "").lower() == "true"
    is_test = (
        is_test_project_property
        or "test" in file_name
        or any(part.lower().endswith(".tests") or part.lower().endswith(".test") for part in relative_parts)
        or bool(package_names & KNOWN_TEST_PACKAGES)
    )

    return {
        "path": str(path.relative_to(root)),
        "sdk": xml.attrib.get("Sdk"),
        "target_frameworks": target_frameworks,
        "output_type": text_of(xml, "OutputType"),
        "nullable": text_of(xml, "Nullable"),
        "implicit_usings": text_of(xml, "ImplicitUsings"),
        "lang_version": text_of(xml, "LangVersion"),
        "root_namespace": text_of(xml, "RootNamespace"),
        "assembly_name": text_of(xml, "AssemblyName"),
        "is_likely_test_project": is_test,
        "package_references": packages,
        "project_references": project_refs(xml, path, root),
        "analyzer_references": analyzer_refs(xml, packages),
    }


def maybe_json_file(path: Path, root: Path) -> dict[str, object]:
    try:
        data = json.loads(path.read_text(encoding="utf-8-sig"))
    except (OSError, json.JSONDecodeError):
        data = None
    return {"path": str(path.relative_to(root)), "json": data}


def inspect(path: Path) -> dict[str, object]:
    target = path.resolve()
    if target.is_file():
        root = target.parent
    else:
        root = target

    if not root.exists():
        raise FileNotFoundError(str(root))

    csproj_files = [target] if target.is_file() and target.suffix == ".csproj" else iter_files(root, ("*.csproj",))
    sln_files = iter_files(root, ("*.sln", "*.slnx"))

    special_names = (
        "global.json",
        "Directory.Build.props",
        "Directory.Build.targets",
        "Directory.Packages.props",
        "NuGet.config",
        ".editorconfig",
    )
    special_files = [
        file
        for file in iter_files(root, tuple(special_names))
        if file.name in special_names
    ]

    appsettings = [
        file
        for file in iter_files(root, ("appsettings*.json", "launchSettings.json"))
        if file.name.startswith("appsettings") or file.name == "launchSettings.json"
    ]

    central_package_files = [file for file in special_files if file.name == "Directory.Packages.props"]
    projects = [project_info(file, root, central_package_files) for file in csproj_files]
    frameworks = sorted({fw for project in projects for fw in project.get("target_frameworks", [])})

    return {
        "root": str(root),
        "solutions": [str(file.relative_to(root)) for file in sln_files],
        "projects": projects,
        "target_frameworks": frameworks,
        "central_package_versions": [
            {
                "path": str(file.relative_to(root)),
                "packages": central_package_versions(file),
            }
            for file in central_package_files
        ],
        "editorconfig_files": [
            str(file.relative_to(root))
            for file in special_files
            if file.name == ".editorconfig"
        ],
        "special_files": [str(file.relative_to(root)) for file in special_files],
        "json_config_files": [maybe_json_file(file, root) for file in appsettings],
    }


def main() -> int:
    parser = argparse.ArgumentParser(description="Inspect C# solution and project metadata.")
    parser.add_argument("path", help="Repository, solution directory, or .csproj path")
    parser.add_argument("--pretty", action="store_true", help="Pretty-print JSON output")
    args = parser.parse_args()

    try:
        result = inspect(Path(args.path))
    except Exception as exc:
        print(json.dumps({"error": str(exc)}, indent=2), file=sys.stderr)
        return 1

    print(json.dumps(result, indent=2 if args.pretty else None, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
