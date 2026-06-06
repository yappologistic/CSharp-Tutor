# C# LINQ Guidance

Use this reference for `IEnumerable<T>`, LINQ operators, deferred execution, joins, filtering, projection, grouping, and repeated enumeration.

## Mental Model

- `IEnumerable<T>` means "a sequence you can iterate over."
- LINQ operators transform, filter, group, join, or aggregate sequences.
- Many LINQ queries are lazy: they do not run until enumerated.

## Common Operators

- `Where`: filter items.
- `Select`: transform items.
- `Any`: check if at least one item exists or matches.
- `First`, `FirstOrDefault`, `Single`, `SingleOrDefault`: retrieve specific items with different expectations.
- `OrderBy`, `ThenBy`: sort.
- `GroupBy`: group by a key.
- `Join`: combine two sequences by matching keys.
- `ToList`, `ToArray`, `ToDictionary`: materialize a query.

## Common Pitfalls

- Repeated enumeration can repeat work or queries.
- `First` throws when no item exists; `FirstOrDefault` can return a default value.
- `Single` throws when zero or multiple items exist.
- LINQ over EF Core may translate to SQL, not run like in-memory LINQ.
- LINQ can hide allocations or complexity in hot paths.
- Deferred execution can observe changed source data later.

## Teaching Shape

When teaching LINQ:

1. Show the source collection.
2. Show the query.
3. Show when the query executes.
4. Show the output.
5. Mention the relevant pitfall.
