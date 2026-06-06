---
name: csharp-review
description: Review C# snippets, files, projects, or codebases for correctness, bugs, object-oriented design, clean code, SOLID, maintainability, scalability, performance, security, tests, and modernization opportunities.
metadata:
  short-description: Review C# code for quality and bugs
---

# C# Review

Use `$csharp-tutor mode=review`.

Treat all user text after `$csharp-review` as the code, file path, project path, or review goal. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/review-checklist.md`
- `references/common-csharp-pitfalls.md`
- `references/security-review-map.md`
- `references/performance-review-map.md`
- `references/code-smell-to-refactor.md`
- `references/project-inspection.md`
- `references/answer-quality-rules.md`
- `references/review-profiles.md`
- `references/review-output-contracts.md`

Honor `scope=correctness|security|performance|architecture|tests|all` and `format=findings|before-after|checklist|mentor|table` when provided. Report findings first, ordered by correctness, security/future bugs, maintainability/design, performance, modernization, then optional tips.
