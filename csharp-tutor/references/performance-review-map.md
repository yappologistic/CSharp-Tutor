# Performance Review Map

Use this reference when reviewing performance, scalability, allocations, hot paths, or server throughput.

## First Principles

- Ask whether the path is hot, user-facing, high-volume, or resource-constrained.
- Prefer algorithmic and I/O improvements before micro-optimizations.
- Recommend measurement for non-obvious claims: BenchmarkDotNet for isolated code, profiling/tracing for full applications.
- Preserve readability unless the performance gain is meaningful.

## Common C# Performance Checks

| Area | Watch For | Direction |
| --- | --- | --- |
| Algorithms | Nested loops over large data, repeated scans | Use indexes, dictionaries, sets, batching, or better data shape. |
| Allocations | Repeated string concatenation, closures, LINQ in hot loops, boxing | Use `StringBuilder`, spans, pooling, structs carefully, or explicit loops when measured. |
| LINQ | Multiple enumeration, provider translation surprises, hidden allocations | Materialize once when needed; inspect EF queries; avoid LINQ in measured hot paths. |
| Async | Sync I/O, blocked threads, missing cancellation, fire-and-forget tasks | Use async APIs end-to-end; pass cancellation; handle background failures. |
| Collections | Wrong lookup structure, repeated sorting, unbounded lists | Choose `Dictionary`, `HashSet`, priority queues, immutable or concurrent collections as appropriate. |
| Strings | Culture-sensitive comparison, allocation-heavy formatting | Use explicit `StringComparison`, interpolation appropriately, spans only when justified. |
| Memory | Large object heap pressure, buffering entire streams, unbounded caches | Stream data, bound caches, pool carefully, avoid retaining large graphs. |
| Concurrency | Lock contention, mutable shared state, thread pool starvation | Reduce shared state, use async coordination, channels, concurrent collections, or partitioning. |
| EF/Data Access | N+1 queries, loading too much data, tracking when not needed | Project only needed fields, use `AsNoTracking`, include intentionally, batch operations. |

## Benchmarking Guidance

- Use BenchmarkDotNet for small deterministic comparisons.
- Use realistic inputs and include edge cases.
- Avoid optimizing based only on intuition.
- Report tradeoffs such as complexity, allocation reduction, readability, and compatibility.

## When to Suggest Advanced APIs

Suggest `Span<T>`, `Memory<T>`, pooling, source generators, SIMD, channels, or pipelines only when:

- The target framework supports the API.
- The code path is performance-sensitive.
- The user can maintain the added complexity.
- The change has a plausible measurement or strong official guidance behind it.
