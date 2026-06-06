---
name: csharp-performance
description: Review C# and .NET code for performance, memory, allocations, LINQ overhead, async scalability, data access, EF Core queries, concurrency, throughput, benchmarking, profiling, and scalable implementation choices.
metadata:
  short-description: Performance review for C# code
---

# C# Performance

Use `$csharp-tutor mode=performance`.

Treat all user text after `$csharp-performance` as the code, query, project, or performance concern. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/performance-review-map.md`
- `references/aot-guidance.md`
- `references/tooling-and-analyzers.md`
- `references/project-inspection.md`
- `references/framework-guidance.md`
- `references/verification-checklist.md`

Avoid unsupported performance claims. Recommend measurement, profiling, or BenchmarkDotNet when the performance tradeoff is not obvious.
