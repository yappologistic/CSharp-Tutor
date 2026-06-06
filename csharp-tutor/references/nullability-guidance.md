# Nullability Guidance

Use this reference for nullable reference types, nullable warnings, null contracts, and null-safety reviews.

## Core Principles

- Treat nullable warnings as design feedback, not formatting noise.
- Prefer making invalid null states unrepresentable over adding scattered null checks.
- Distinguish compile-time nullability annotations from runtime validation. An annotation does not validate external input.
- Avoid the null-forgiving operator `!` unless a framework contract or invariant truly guarantees non-null initialization.
- Keep public API null contracts explicit because callers depend on them.

## Beginner Explanation

- `string` means the variable should not be null.
- `string?` means the variable may be null and must be checked before dereferencing.
- Nullable reference types are compiler analysis, not a runtime feature that prevents nulls.
- `!` suppresses a warning; it does not check or fix the value.

## Common Fix Patterns

- Initialize non-nullable properties through constructors, `required` members, or safe defaults.
- Use guard clauses for required method arguments:

```csharp
ArgumentNullException.ThrowIfNull(customer);
```

- Return an empty collection instead of null when absence and emptiness mean the same thing.
- Use `TryGetValue`, pattern matching, or early returns to narrow nullable values before use.
- For optional values, make null part of the contract with `T?` and document what null means.
- For required configuration or dependency values, fail fast during startup or construction.

## Review Checklist

- Are non-nullable fields and properties definitely initialized?
- Are external inputs validated even when annotations say non-null?
- Are nullable return values checked before dereference?
- Is `!` used only with a clear invariant?
- Are collection-returning APIs unnecessarily nullable?
- Are DTOs, EF Core entities, and serialization models handling framework initialization correctly?
- Are public API changes to nullability compatible with existing callers?

## Framework Notes

- ASP.NET Core model binding, JSON deserialization, EF Core materialization, and test frameworks may construct objects outside normal constructors.
- For DTOs, prefer explicit validation over relying only on nullable annotations.
- For EF Core entities, avoid using `!` reflexively. Consider constructor binding, required members when compatible, or documented framework initialization.
- For libraries, changing `T` to `T?` or `T?` to `T` can affect callers and should be treated as API compatibility work.

## When To Cite Official Docs

Cite official Microsoft documentation when the answer depends on:

- Nullable reference type language rules.
- Warning behavior or compiler analysis.
- Attribute-based null-state annotations.
- C# or .NET version support.
- Public API compatibility or library guidance.
