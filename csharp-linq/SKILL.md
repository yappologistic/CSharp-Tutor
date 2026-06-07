---
name: csharp-linq
description: Teach and review C# LINQ and IEnumerable. Use for IEnumerable sequences, LINQ filtering, projection, joins, grouping, sorting, deferred execution, query syntax, method syntax, repeated enumeration, EF Core query translation, and collection-processing questions.
metadata:
  short-description: C# LINQ and IEnumerable help
---

# C# LINQ

Use `$csharp-tutor mode=linq`.

Treat all user text after `$csharp-linq` as the LINQ, `IEnumerable<T>`, collection, query, or data transformation question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/skill-routing.md`
- `references/linq-guidance.md`
- `references/common-csharp-pitfalls.md`
- `references/performance-review-map.md`
- `references/framework-guidance.md`
- `references/official-sources.md`

Default to beginner-friendly examples with small collections. Explain deferred execution and repeated enumeration when relevant.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete linq decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the linq concern.
- Minimal example: `var names = users.Where(u => u.IsActive).Select(u => u.Name).ToList();`
