---
name: csharp-api-design
description: Teach and review C# public API design. Use for method signatures, naming, nullability, exceptions, result types, cancellation, async APIs, records, DTOs, versioning, binary compatibility, XML docs, NuGet packaging, library boundaries, and maintainable API surfaces.
metadata:
  short-description: C# public API design help
---

# C# API Design

Use `$csharp-tutor mode=api-design`.

Treat all user text after `$csharp-api-design` as a C# API design, public surface, library design, DTO contract, compatibility, or package design question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/api-design-guidance.md`
- `references/versioning-guidance.md`
- `references/docs-grounding.md`
- `references/testing-guidance.md`
- `references/architecture-guidance.md`
- `references/source-citation-rules.md`

Honor `contract=naming|nullability|errors|async|compatibility|docs`. Prioritize clear contracts, predictable errors, nullability, cancellation, async shape, compatibility, and caller ergonomics before internal implementation details.
