# Concurrency Guidance

Use this reference for C# threading, synchronization, shared state, CPU-bound parallelism, race conditions, deadlocks, channels, and concurrent collections.

## First Distinction

- Async I/O: frees the current thread while waiting for I/O.
- Concurrency: multiple operations are in progress at the same time.
- Parallelism: work runs at the same time on multiple cores.
- Thread safety: shared state remains correct under concurrent access.

## Review Priorities

1. Identify shared mutable state and who can access it.
2. Check synchronization around read and write operations.
3. Look for lock ordering problems and blocking while holding locks.
4. Check cancellation and shutdown paths.
5. Avoid sync-over-async and blocking waits that can deadlock or starve threads.
6. Use concurrent collections only when their semantics match the whole operation.
7. Prefer message passing or immutable snapshots when it simplifies correctness.
8. Verify performance claims with measurement when contention or data size matters.

## Common Feedback

- Keep lock scopes small and never expose the lock object publicly.
- Do not assume `ConcurrentDictionary` makes multi-step workflows atomic unless using the correct atomic operation.
- Use `SemaphoreSlim` for async-compatible throttling, not `lock` around `await`.
- Use `Channel` or producer-consumer patterns for pipelines when appropriate.
- Use `Parallel` or PLINQ only for CPU-bound work with enough independent work to justify overhead.
- Tests should stress concurrency with repeated runs, cancellation, and race-sensitive paths, but passing tests do not prove absence of races.

## Source Standard

Concurrency details are easy to misstate. Verify API behavior, memory/threading guidance, and framework recommendations with official Microsoft docs when the answer depends on precise semantics.
