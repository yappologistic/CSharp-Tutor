---
name: csharp-collections
description: Teach and review C# collections and data structures. Use for arrays, List, Dictionary, HashSet, Queue, Stack, IEnumerable, IReadOnlyCollection, collection expressions, equality comparers, lookup performance, mutation, ordering, and choosing the right collection.
metadata:
  short-description: C# collections and data structures
---

# C# Collections

Use `$csharp-tutor mode=collections`.

Treat all user text after `$csharp-collections` as a C# collections, data structure, enumeration, or collection-performance question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/collections-guidance.md`
- `references/linq-guidance.md`
- `references/performance-review-map.md`
- `references/common-csharp-pitfalls.md`
- `references/official-sources.md`
- `references/source-citation-rules.md`

Start by identifying the access pattern: ordered iteration, lookup by key, uniqueness, queue behavior, stack behavior, immutability, or read-only exposure. Then recommend the simplest collection that matches the behavior.
