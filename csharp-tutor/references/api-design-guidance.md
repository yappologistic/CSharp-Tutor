# API Design Guidance

Use this reference for C# public API design, library boundaries, DTOs, method signatures, compatibility, and caller ergonomics.

## First Checks

- Identify whether the API is internal app code, public library code, web API DTOs, package surface, or plugin/extension surface.
- Identify callers, compatibility expectations, target frameworks, nullability setting, async needs, cancellation needs, and versioning constraints.
- For public packages, consider XML docs, analyzers, trimming, AOT, source/binary compatibility, and semantic versioning.

## Review Priorities

1. Clear names that describe caller intent.
2. Explicit nullability and input contracts.
3. Predictable exceptions or result types for expected failures.
4. Async APIs that return `Task` or `ValueTask` only when appropriate and accept `CancellationToken` for cancellable I/O.
5. Minimal public surface area.
6. DTOs and records that model contracts without leaking persistence entities.
7. Backward compatibility for public APIs.
8. Test coverage for edge cases and contract behavior.

## Contract Focus

Honor `contract=...`:

- `contract=naming`: names, overloads, parameter clarity, Boolean traps, caller intent.
- `contract=nullability`: nullable annotations, null handling, empty collections, guard clauses.
- `contract=errors`: exceptions, result types, validation failures, documented failure modes.
- `contract=async`: `Task`, `ValueTask`, cancellation, sync/async pairs, exception flow.
- `contract=compatibility`: source/binary compatibility, serialized shape, versioning, public surface changes.
- `contract=docs`: XML docs, examples, exception docs, cancellation docs, ownership/disposal notes.

## Common Feedback

- Avoid Boolean parameters that obscure meaning; prefer named options or separate methods when behavior diverges.
- Avoid returning mutable internal collections.
- Use `IReadOnlyList` or `IReadOnlyCollection` when callers should not mutate results.
- Do not expose framework or infrastructure details through domain-facing APIs unless the boundary is explicitly framework-specific.
- Prefer options objects when parameters grow or are often passed together.
- Document exceptions, cancellation behavior, nullability, threading assumptions, and ownership/disposal expectations.
- For web APIs, separate request/response DTOs from persistence entities.

## Compatibility Notes

- Adding optional parameters can affect source and binary compatibility in subtle ways.
- Changing public return types, exceptions, nullability contracts, or serialized DTO shapes can be breaking.
- Verify compatibility-sensitive claims with official docs or project/package policy.
