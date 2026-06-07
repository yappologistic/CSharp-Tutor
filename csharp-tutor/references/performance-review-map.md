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

## Before/After Examples

### Repeated Lookup

Slow for repeated membership checks:

```csharp
var active = users.Where(u => activeIds.Contains(u.Id)).ToList();
```

If `activeIds` is a large list, convert once:

```csharp
var activeIdSet = activeIds.ToHashSet();
var active = users.Where(u => activeIdSet.Contains(u.Id)).ToList();
```

### Multiple Enumeration

Risky:

```csharp
var expensive = source.Where(x => IsMatch(x));
Console.WriteLine(expensive.Count());
return expensive.ToList();
```

Better:

```csharp
var expensive = source.Where(x => IsMatch(x)).ToList();
Console.WriteLine(expensive.Count);
return expensive;
```

### String Building

Allocation-heavy in loops:

```csharp
var csv = "";
foreach (var item in items)
{
    csv += item.Name + ",";
}
```

Better for repeated concatenation:

```csharp
var builder = new StringBuilder();
foreach (var item in items)
{
    builder.Append(item.Name).Append(',');
}
var csv = builder.ToString();
```

### EF Projection

Loads more data than needed:

```csharp
var users = await db.Users.ToListAsync();
return users.Select(u => new UserSummary(u.Id, u.Name)).ToList();
```

Better:

```csharp
return await db.Users
    .AsNoTracking()
    .Select(u => new UserSummary(u.Id, u.Name))
    .ToListAsync();
```

## Benchmarking Guidance

Use BenchmarkDotNet for small deterministic comparisons:

```csharp
[MemoryDiagnoser]
public class LookupBenchmarks
{
    private readonly List<int> _ids = Enumerable.Range(0, 10_000).ToList();
    private readonly HashSet<int> _set = Enumerable.Range(0, 10_000).ToHashSet();

    [Benchmark]
    public bool ListContains() => _ids.Contains(9_999);

    [Benchmark]
    public bool SetContains() => _set.Contains(9_999);
}
```

For full applications, prefer profiling, tracing, logs, and realistic load tests.

## When to Suggest Advanced APIs

Suggest `Span<T>`, `Memory<T>`, pooling, source generators, SIMD, channels, or pipelines only when:

- The target framework supports the API.
- The code path is performance-sensitive.
- The user can maintain the added complexity.
- The change has a plausible measurement or strong official guidance behind it.

## Response Pattern

```text
Likely bottleneck: ...
Why: ...
Low-risk fix: ...
Measure with: ...
Tradeoff: ...
```
