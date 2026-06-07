---
name: csharp-analyzers
description: Teach and review C# Roslyn analyzers, .editorconfig, nullable warnings, warning levels, TreatWarningsAsErrors, WarningsAsErrors, NoWarn, EnforceCodeStyleInBuild, dotnet format, analyzer packages, StyleCop, SonarAnalyzer, Roslynator, code quality gates, and CI analyzer enforcement.
metadata:
  short-description: C# analyzers and .editorconfig help
---

# C# Analyzers

Use `$csharp-tutor mode=analyzers`.

Treat all user text after `$csharp-analyzers` as the analyzer warning, `.editorconfig`, build warning, nullable warning, formatting, suppression, warning-as-error, analyzer package, or CI quality gate question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/analyzers-guidance.md`
- `references/analyzer-tooling-guidance.md`
- `references/tooling-and-analyzers.md`
- `references/nullability-guidance.md`
- `references/style-guidance.md`
- `references/build-guidance.md`
- `references/security-review-map.md`
- `references/official-sources.md`

Classify each diagnostic before advising: compiler, nullable, correctness, security, performance, maintainability, style, or formatting. Do not recommend making all warnings errors until the project has a clean and sustainable baseline.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete analyzers decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the analyzers concern.
- Minimal example: `dotnet format --verify-no-changes`
