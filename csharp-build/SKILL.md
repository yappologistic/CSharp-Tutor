---
name: csharp-build
description: Diagnose and explain C# and .NET build, restore, test, format, SDK, MSBuild, project-file, and CI build issues. Use for dotnet clean/build/test/restore/format, .csproj, .sln, global.json, SDK resolution, NuGet package restore, compiler and analyzer errors, warning-as-error failures, MSBuild targets, binary logs, and CI build failures.
metadata:
  short-description: C# build, SDK, and CI help
---

# C# Build

Use `$csharp-tutor mode=build`.

Treat all user text after `$csharp-build` as the build command, error output, project file, CI failure, SDK issue, restore problem, or tooling question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/build-guidance.md`
- `references/project-inspection.md`
- `references/tooling-and-analyzers.md`
- `references/analyzer-tooling-guidance.md`
- `references/compiler-error-library.md`
- `references/testing-guidance.md`
- `references/versioning-guidance.md`
- `references/official-sources.md`

Start by classifying the failure: SDK resolution, restore, project configuration, compiler/analyzer, test runner, or CI environment. Ask for or inspect the exact command and error output before recommending broad cleanup.
