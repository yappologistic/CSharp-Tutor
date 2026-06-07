---
name: csharp-style
description: Teach and review C# naming conventions, formatting, idiomatic style, .editorconfig, analyzer rules, dotnet format, nullable style, field/property naming, interface naming, and code readability.
metadata:
  short-description: C# naming, formatting, and style
---

# C# Style

Use `$csharp-tutor mode=style`.

Treat all user text after `$csharp-style` as the C# naming, formatting, style, analyzer, or readability question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/cross-skill-composition.md`
- `references/style-guidance.md`
- `references/nullability-guidance.md`
- `references/analyzers-guidance.md`
- `references/tooling-and-analyzers.md`
- `references/analyzer-tooling-guidance.md`
- `references/answer-quality-rules.md`
- `references/official-sources.md`

Separate style conventions from correctness. Prefer the project's `.editorconfig` when present.

Decision rules:

- If code does not compile, route to `csharp-debug` or `csharp-build` before style cleanup.
- If the question is about analyzer enforcement, include `csharp-analyzers` as a supporting lens.
- If naming affects public API compatibility, include `csharp-api-design`.
- If nullable annotations change contracts, include `csharp-nullability`.

For reviews, separate:

1. Project-enforced rules from `.editorconfig` or analyzers.
2. C# conventions that are broadly idiomatic.
3. Optional readability preferences.

Avoid presenting personal taste as correctness. Give concrete before/after examples for naming or formatting feedback.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete style decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the style concern.
- Minimal example: `private readonly IClock _clock;`
