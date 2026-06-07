---
name: csharp-json
description: Teach and review JSON serialization and deserialization in C#. Use for System.Text.Json, DTOs, records, JSON persistence, reading/writing JSON files, JsonSerializer, nullable deserialization results, options, property naming, dates, decimals, enums, and common beginner JSON issues.
metadata:
  short-description: C# JSON serialization help
---

# C# JSON

Use `$csharp-tutor mode=json`.

Treat all user text after `$csharp-json` as the C# JSON, serialization, deserialization, DTO, or persistence question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/json-guidance.md`
- `references/sourcegen-guidance.md`
- `references/official-sources.md`
- `references/security-review-map.md`
- `references/learner-levels.md`
- `references/testing-guidance.md`

Explain serialization with small examples and show how to inspect restored values. Warn about null results, untrusted input, and mixing persistence with domain logic.
