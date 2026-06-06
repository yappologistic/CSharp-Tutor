---
name: csharp-async
description: Teach and review C# async programming. Use for async/await, Task, generic Task results, ValueTask, cancellation tokens, async tests, fire-and-forget tasks, sync-over-async, deadlocks, I/O-bound work, background work, and async performance or correctness issues.
metadata:
  short-description: C# async, Task, and cancellation help
---

# C# Async

Use `$csharp-tutor mode=async`.

Treat all user text after `$csharp-async` as the async concept, code, bug, test, or design question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/skill-routing.md`
- `references/async-guidance.md`
- `references/common-csharp-pitfalls.md`
- `references/testing-guidance.md`
- `references/performance-review-map.md`
- `references/official-sources.md`

Default to beginner-friendly explanations. Explain what `Task`, `async`, and `await` mean before discussing advanced concurrency details unless the user asks for depth.
