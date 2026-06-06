---
name: csharp-concurrency
description: Teach and review C# concurrency and thread-safety. Use for threads, locks, Monitor, SemaphoreSlim, ReaderWriterLockSlim, concurrent collections, channels, Parallel, Task coordination, race conditions, shared state, deadlocks, cancellation, and CPU-bound parallel work.
metadata:
  short-description: C# concurrency and thread-safety
---

# C# Concurrency

Use `$csharp-tutor mode=concurrency`.

Treat all user text after `$csharp-concurrency` as a C# concurrency, threading, synchronization, parallelism, race-condition, or shared-state question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/concurrency-guidance.md`
- `references/async-guidance.md`
- `references/performance-review-map.md`
- `references/common-csharp-pitfalls.md`
- `references/source-citation-rules.md`
- `references/testing-guidance.md`

Separate async I/O from concurrency and CPU-bound parallelism. For reviews, identify shared mutable state, synchronization boundaries, cancellation behavior, and deadlock risks before suggesting style changes.
