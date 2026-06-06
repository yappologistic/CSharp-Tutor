# Analyzer Guidance

Use this reference for Roslyn analyzers, `.editorconfig`, warning levels, nullable warnings, `TreatWarningsAsErrors`, `NoWarn`, `dotnet format`, package analyzers, and CI quality gates.

## First Checks

- Inspect `.editorconfig`, project files, `Directory.Build.props`, and CI commands.
- Check `AnalysisLevel`, `AnalysisMode`, `Nullable`, `TreatWarningsAsErrors`, `WarningsAsErrors`, `NoWarn`, and `EnforceCodeStyleInBuild`.
- Identify analyzer packages such as `Microsoft.CodeAnalysis.NetAnalyzers`, StyleCop, SonarAnalyzer, Meziantou.Analyzer, or Roslynator.
- Separate compiler errors, nullable warnings, analyzer warnings, and IDE style suggestions.

## Common Commands

```powershell
dotnet build
dotnet format --verify-no-changes
dotnet format analyzers
dotnet format style
```

For focused diagnostics:

```powershell
dotnet build -warnaserror
dotnet build -property:TreatWarningsAsErrors=true
```

## Severity Guidance

- Make correctness, security, reliability, and public API warnings visible early.
- Use warning-as-error selectively after the team has a sustainable baseline.
- Do not hide meaningful warnings with broad `NoWarn`.
- Prefer `.editorconfig` for explicit per-rule severity.
- Keep style-only rules from blocking urgent fixes unless the team explicitly wants that workflow.

## Review Checklist

- Are analyzer severities aligned with project maturity?
- Are nullable warnings treated as correctness/design feedback?
- Are security and reliability rules enabled where risk is meaningful?
- Are broad suppressions justified and documented?
- Does CI run build, tests, format/analyzer checks, and package vulnerability checks when appropriate?
- Are automatic fixes reviewed when they may change behavior or public API?

## Response Pattern

1. Identify the diagnostic category.
2. Explain why the rule matters or why it may be only style.
3. Suggest the smallest code or `.editorconfig` fix.
4. Call out when suppressing is reasonable and where to document it.
5. Recommend CI enforcement only after baseline cleanup.
