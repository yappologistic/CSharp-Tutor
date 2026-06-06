# Collections Guidance

Use this reference for arrays, `List`, `Dictionary`, `HashSet`, `Queue`, `Stack`, `IEnumerable`, read-only collection interfaces, equality comparers, mutation, ordering, and collection performance.

## Choose By Access Pattern

- Ordered, index-based mutable sequence: `List`.
- Fixed-size or interop-friendly contiguous storage: array.
- Lookup by key: `Dictionary`.
- Unique items and membership tests: `HashSet`.
- First-in-first-out processing: `Queue`.
- Last-in-first-out processing: `Stack`.
- Expose read-only behavior: `IReadOnlyList`, `IReadOnlyCollection`, or `IEnumerable` depending on what callers need.
- Stream or lazily compose values: `IEnumerable`, but explain deferred execution and repeated enumeration.

## Review Priorities

1. Match the collection to the actual read/write/lookup pattern.
2. Check equality semantics for dictionaries and sets, especially custom types.
3. Avoid exposing mutable internal collections directly.
4. Avoid repeated enumeration of expensive or side-effecting `IEnumerable` sequences.
5. Avoid modifying a collection while enumerating it unless using a safe pattern.
6. Consider capacity, allocation, and lookup complexity only when the code is hot or data size is meaningful.
7. Verify newer collection syntax or APIs against the project's target C# and .NET version.

## Common Feedback

- Use `Dictionary.TryGetValue` when absence is expected.
- Use `HashSet` for repeated membership checks.
- Materialize with `ToList` only when you need a snapshot or repeated traversal.
- Prefer read-only interfaces for outputs when callers should not mutate the collection.
- Do not claim performance wins without data size, complexity reasoning, generated SQL if applicable, or measurement.
