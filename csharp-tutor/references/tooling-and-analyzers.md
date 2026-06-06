# Tooling and Analyzers

Use this reference when the user wants concrete verification steps, project hygiene, analyzer guidance, formatting, dependency checks, or CI-ready commands.

## Useful Commands

Run from the solution or project directory when available:

```powershell
dotnet --info
dotnet build
dotnet test
dotnet format
dotnet list package
dotnet list package --outdated
dotnet list package --vulnerable
dotnet list package --deprecated
```

Prefer targeted commands for large repositories:

```powershell
dotnet build path\to\Project.csproj
dotnet test path\to\Tests.csproj --filter "FullyQualifiedName~Name"
```

## Analyzer Guidance

- Treat compiler errors and nullable warnings as correctness signals.
- Treat analyzer warnings by category: correctness, security, performance, maintainability, style.
- Do not ask the user to enable every analyzer blindly; recommend analyzers based on project maturity and pain points.
- Use `.editorconfig` to make style and analyzer severity explicit.
- Use `Directory.Build.props` for repo-wide analyzer and warning settings when appropriate.
- Consider `TreatWarningsAsErrors` selectively for CI or core projects after baseline cleanup.

## Common Tooling Signals

| Signal | What It Suggests |
| --- | --- |
| Nullable warnings | Missing contracts, invalid assumptions, unsafe external input handling. |
| CA warnings | Framework design, reliability, security, or maintainability guidance. |
| IDE suggestions | Often style or simplification; separate from correctness. |
| Vulnerable packages | Dependency security review needed before release. |
| Deprecated packages | Migration or replacement planning needed. |
| Format diffs | Style consistency problem, not usually a design issue. |

## Package and Dependency Checks

- Use `dotnet list package --vulnerable` for known vulnerability checks.
- Use `dotnet list package --outdated` for maintenance signals, not automatic upgrades.
- Review transitive dependencies when packages bring broad dependency graphs.
- Prefer central package management for multi-project repositories when version drift is recurring.
- Verify package upgrade compatibility with tests and release notes.

## Feedback Style

When suggesting tools, explain:

- What command to run.
- What signal it provides.
- How to interpret likely results.
- Whether it is required for correctness/security or optional hygiene.
