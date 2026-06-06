# Analyzer and Tooling Guidance

Use this reference for Roslyn analyzers, `.editorconfig`, nullable warnings, formatting, package audits, code metrics, and CI checks.

## Inspect First

Look for:

- `.editorconfig`
- `Directory.Build.props`
- `Directory.Packages.props`
- `NuGet.config`
- `global.json`
- Project `AnalysisLevel`, `Nullable`, `TreatWarningsAsErrors`, `WarningsAsErrors`, `NoWarn`, and `LangVersion`
- Analyzer packages such as StyleCop, SonarAnalyzer, Meziantou.Analyzer, Roslynator, Microsoft.CodeAnalysis.NetAnalyzers

## Common Commands

- `dotnet build` for compiler and analyzer diagnostics.
- `dotnet test` for test verification.
- `dotnet format` for formatting and analyzer fixes.
- `dotnet list package --vulnerable` for known vulnerable package checks.
- `dotnet list package --outdated` for update discovery.
- `dotnet workload list` when workloads matter.

## Review Priorities

1. Do not hide meaningful warnings with broad `NoWarn`.
2. Enable nullable reference types for new code when feasible.
3. Treat warnings as errors selectively when the team can sustain it.
4. Keep analyzer severity aligned with team goals; do not make style nits block urgent work by default.
5. Use `.editorconfig` to make conventions explicit.
6. Prefer focused analyzer packages over a noisy pile of rules.
7. Include CI commands that prove formatting, build, tests, and package risk checks.

## Teaching Notes

Explain warnings as feedback loops, not personal criticism. For learners, show one warning, why it matters, and the smallest fix.
