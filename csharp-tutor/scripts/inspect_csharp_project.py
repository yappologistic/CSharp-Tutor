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
    "xunit.runner.visualstudio",
    "NUnit",
    "NUnit3TestAdapter",
    "MSTest.TestAdapter",
    "MSTest.TestFramework",
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


def text_of(parent: ET.Element, name: str) -> str | None:
    element = parent.find(f".//{name}")
    if element is None or element.text is None:
        return None
    value = element.text.strip()
    return value or None


def all_text(parent: ET.Element, name: str) -> list[str]:
    values: list[str] = []
    for element in parent.findall(f".//{name}"):
        if element.text and element.text.strip():
            values.append(element.text.strip())
    return values


def package_refs(parent: ET.Element) -> list[dict[str, str | None]]:
    refs: list[dict[str, str | None]] = []
    for element in parent.findall(".//PackageReference"):
        include = element.attrib.get("Include") or element.attrib.get("Update")
        version = element.attrib.get("Version")
        if version is None:
            version_node = element.find("Version")
            version = version_node.text.strip() if version_node is not None and version_node.text else None
        if include:
            refs.append({"name": include, "version": version})
    return sorted(refs, key=lambda item: item["name"] or "")


def project_info(path: Path, root: Path) -> dict[str, object]:
    xml = read_xml(path)
    if xml is None:
        return {"path": str(path.relative_to(root)), "parse_error": True}

    target_frameworks = all_text(xml, "TargetFramework") + all_text(xml, "TargetFrameworks")
    packages = package_refs(xml)
    package_names = {str(pkg["name"]) for pkg in packages}
    file_name = path.name.lower()
    is_test = (
        "test" in file_name
        or any(part.lower().endswith(".tests") or part.lower().endswith(".test") for part in path.parts)
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

    projects = [project_info(file, root) for file in csproj_files]
    frameworks = sorted({fw for project in projects for fw in project.get("target_frameworks", [])})

    return {
        "root": str(root),
        "solutions": [str(file.relative_to(root)) for file in sln_files],
        "projects": projects,
        "target_frameworks": frameworks,
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
