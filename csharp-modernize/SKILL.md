---
name: csharp-modernize
description: Modernize C# code using newer C# and .NET features when compatible. Use for refactoring older syntax, adopting records, pattern matching, nullable annotations, required members, collection expressions, modern BCL APIs, async improvements, and version-aware upgrades.
metadata:
  short-description: Modernize C# with newer features
---

# C# Modernize

Use `$csharp-tutor mode=modernize`.

Treat all user text after `$csharp-modernize` as the code, project, or feature-modernization question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/modernization-map.md`
- `references/versioning-guidance.md`
- `references/project-inspection.md`
- `references/official-sources.md`
- `references/verification-checklist.md`
- `references/source-citation-rules.md`
- `references/testing-guidance.md`

Confirm or infer target C#/.NET version before suggesting newer features. Show before/after code and compatibility tradeoffs.
