---
name: csharp-nullability
description: Teach and review C# nullable reference types and null-safety. Use for nullable warnings, nullable annotations, null-forgiving operator, required members, null checks, guard clauses, NullReferenceException prevention, DTOs, EF Core entities, ASP.NET Core model binding, public API null contracts, and migration to nullable-enabled C# projects.
metadata:
  short-description: C# nullable reference type help
---

# C# Nullability

Use `$csharp-tutor mode=nullability`.

Treat all user text after `$csharp-nullability` as the nullable reference type concept, warning, code review, migration, API contract, or null-safety question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/nullability-guidance.md`
- `references/analyzers-guidance.md`
- `references/common-csharp-pitfalls.md`
- `references/style-guidance.md`
- `references/errors-guidance.md`
- `references/api-design-guidance.md`
- `references/versioning-guidance.md`
- `references/official-sources.md`
- `references/source-citation-rules.md`

Default to beginner-friendly explanations that distinguish annotations from runtime validation. Treat `!` as a last-resort warning suppression, not a normal fix. When reviewing code, separate correctness risks from cleanup and migration tips.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete nullability decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the nullability concern.
- Minimal example: `public required string Email { get; init; }`
