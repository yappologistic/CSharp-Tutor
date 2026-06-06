# Build Guidance

Use this reference for C#/.NET build, restore, SDK, project-file, and CI build issues.

## First Checks

- Identify the command that failed: `dotnet restore`, `dotnet build`, `dotnet test`, `dotnet format`, IDE build, or CI job.
- Capture the exact error text, target framework, SDK version, current directory, and project or solution path.
- Inspect `global.json`, `.sln`, `.csproj`, `Directory.Build.props`, `Directory.Build.targets`, `Directory.Packages.props`, and NuGet configuration when available.
- Distinguish compiler diagnostics from SDK resolution, NuGet restore, MSBuild target, analyzer, and test runner failures.

## Useful Commands

```powershell
dotnet --info
dotnet --list-sdks
dotnet restore
dotnet build --no-restore
dotnet test --no-build
dotnet clean
dotnet format --verify-no-changes
```

For noisy build failures, prefer a binary log when appropriate:

```powershell
dotnet build -bl
```

## Common Failure Areas

- SDK mismatch from `global.json` or missing installed SDK.
- Target framework not supported by the installed SDK.
- Restore failures from package version conflicts, missing feeds, credentials, or central package management.
- Project references that point to missing or incompatible projects.
- Nullable, analyzer, or warning-as-error failures.
- CI working directory differences compared with local builds.
- Generated files, source generators, or build targets that depend on environment variables.

## Response Pattern

1. State the likely failure category.
2. Give the smallest command or file check that confirms it.
3. Suggest the smallest safe fix.
4. Mention when to clean, restore, rebuild, or capture a binary log.
5. Avoid recommending broad cache deletion until narrower checks fail.

## Safety Notes

- Do not suggest deleting project files, lock files, package caches, or generated output without explaining impact.
- Prefer project-local fixes over machine-wide SDK or NuGet changes when possible.
- For CI failures, compare local and CI SDK versions, environment variables, working directory, and restore sources before changing code.
