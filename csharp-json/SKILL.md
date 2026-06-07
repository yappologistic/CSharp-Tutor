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

- `references/cross-skill-composition.md`
- `references/json-guidance.md`
- `references/sourcegen-guidance.md`
- `references/official-sources.md`
- `references/security-review-map.md`
- `references/learner-levels.md`
- `references/testing-guidance.md`

Explain serialization with small examples and show how to inspect restored values. Warn about null results, untrusted input, and mixing persistence with domain logic.

Decision rules:

- DTO shape, naming, enum, date, decimal, and options issues stay in `csharp-json`.
- ASP.NET Core request/response behavior should use `csharp-aspnet` as a supporting lens.
- AOT, trimming, or `JsonSerializerContext` questions should use `csharp-sourcegen` or `csharp-aot` as supporting lenses.
- Untrusted JSON, polymorphism, or type metadata risks should include `csharp-security`.

For debugging, ask for the JSON payload, target type, serializer options, and exact exception or restored value. For fixes, show a minimal DTO/options change and one small verification snippet.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete json decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the json concern.
- Minimal example: `var dto = JsonSerializer.Deserialize<OrderDto>(json, options);`
