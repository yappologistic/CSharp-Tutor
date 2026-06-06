# Project Inspection

Use this reference when the user shares a C# repository, asks for codebase review, or when target framework/language version affects the answer.

## Files to Inspect

Look for:

- `*.sln`, `*.slnx`: solution structure.
- `*.csproj`: target framework, output type, nullable settings, packages, analyzers, language version.
- `global.json`: pinned .NET SDK version.
- `Directory.Build.props` and `Directory.Build.targets`: shared build settings.
- `Directory.Packages.props`: central package management.
- `.editorconfig`: analyzer severity, style rules, nullable and formatting expectations.
- `NuGet.config`: package sources and restore behavior.
- `launchSettings.json`, `appsettings*.json`: runtime and configuration clues.
- Test project files: test framework and coverage of behavior.

## Project Inspector Script

When a repository or project path is available, prefer running `scripts/inspect_csharp_project.py <path>` from the `csharp-tutor` skill directory before giving version-sensitive project feedback. Use the script output as a starting inventory, then inspect relevant files directly when the recommendation depends on details the script does not cover.

The script summarizes:

- Solution and project files.
- Target frameworks, output type, nullable setting, implicit usings, language version, SDK style, and package references.
- Shared build files, central package management, SDK pinning, editorconfig, NuGet config, launch settings, appsettings files, and likely test projects.

## Compatibility Inference

Infer in this order:

1. SDK from `global.json`, if present.
2. Target frameworks from project files.
3. Explicit `LangVersion`, if present.
4. Nullable setting from project files or shared props.
5. Package versions and framework-specific dependencies.

If no language version is specified, C# version usually follows the target framework/default SDK rules. Verify with official docs before making version-sensitive claims.

## Modernization Readiness

Before suggesting newer C# or .NET features, check:

- Target framework supports the API or feature.
- `LangVersion` allows the syntax.
- Nullable reference types are enabled if the recommendation depends on them.
- Serializers, ORMs, source generators, AOT/trimming, and public APIs will tolerate the change.
- Tests exist or can be added to protect behavior.

## Review Workflow for Codebases

1. Identify project type and entry points.
2. Inspect build configuration and dependency surface.
3. Build and test when possible.
4. Review high-risk areas first: auth, input, data access, file I/O, concurrency, background jobs, external services.
5. Summarize issue clusters before line-by-line nits.
6. Recommend a small improvement sequence that the user can apply safely.

## Project-Aware Defaults

When a user provides a `.csproj`, `.sln`, or repository path, inspect project configuration before recommending:

- Newer C# language features or .NET APIs.
- Analyzer, nullable, or formatting changes.
- Package upgrades or package audit steps.
- ASP.NET Core, EF Core, trimming, AOT, or deployment-specific guidance.
- Public API or library compatibility changes.

If inspection is not possible, state the assumed target framework/language version and what would change after inspecting the project.

## Summary Levels

Honor `summary=...`:

- `summary=quick`: app type, target framework, language clues, notable packages, top risks.
- `summary=full`: solutions, projects, frameworks, package surface, analyzer/tooling settings, tests, appsettings, risks.
- `summary=risks`: correctness, security, dependency, configuration, framework, and test risks only.
- `summary=modernization`: target framework/language readiness, nullable, analyzers, packages, newer C#/.NET opportunities.
- `summary=tooling`: `.editorconfig`, analyzers, nullable, warnings, format, package audit, CI commands.

## Ask vs Assume

Ask for missing project details only when the answer materially depends on them. Otherwise state the assumption, give the advice, and explain what would change under another target version or framework.
