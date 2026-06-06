# Common C# Pitfalls

Use this reference when reviewing code, debugging likely issues, or teaching habits that prevent defects.

## Nullability

- Treat nullable warnings as design feedback, not noise.
- Prefer non-nullable properties initialized through constructors, `required` members, or safe defaults.
- Avoid `!` unless a framework contract guarantees initialization and the reason is obvious.
- Check external inputs even when nullable annotations say non-null.

## Async

- Avoid `async void` except for event handlers.
- Avoid `.Result`, `.Wait()`, and sync-over-async in application code.
- Pass `CancellationToken` through I/O, request, and background work boundaries.
- Do not ignore returned tasks. Await them or deliberately track/log failures.
- Use `ConfigureAwait(false)` mainly in library code where context capture is unnecessary.

## LINQ and Collections

- Watch for multiple enumeration of `IEnumerable<T>`.
- Prefer `Any()` over `Count() > 0` when only existence matters.
- Use `HashSet<T>` or `Dictionary<TKey,TValue>` for repeated membership/key lookups.
- Avoid LINQ in hot paths when allocations or query translation are a measured issue.
- Know whether a LINQ expression runs in memory or is translated by a provider such as EF Core.

## Time, Culture, and Text

- Avoid `DateTime.Now` for cross-system logic; prefer UTC, `DateTimeOffset`, or `TimeProvider`.
- Specify `StringComparison` for non-linguistic comparisons.
- Use `CultureInfo.InvariantCulture` for machine-readable parse/format.
- Be explicit about encodings for files, streams, and network data.

## Exceptions and Error Handling

- Do not catch broad exceptions unless adding useful handling, translation, cleanup, or context.
- Preserve stack traces with `throw;`, not `throw ex;`.
- Avoid using exceptions for normal control flow.
- Do not leak sensitive details in user-facing errors or logs.

## Equality and Hashing

- Override `Equals` and `GetHashCode` consistently.
- Avoid mutable fields in hash keys used by dictionaries or sets.
- Prefer records for simple immutable value-like data when compatible.

## Shared State and Concurrency

- Avoid mutable static state unless it is immutable after startup or properly synchronized.
- Protect shared collections with locks or concurrent collections.
- Do not assume singleton services are safe if they hold per-request state.
- Use immutable data or message passing when it simplifies concurrency.

## Disposal and Resources

- Dispose streams, database contexts, timers, subscriptions, and handles.
- Use `await using` for `IAsyncDisposable`.
- Avoid returning an object whose underlying stream or context has already been disposed.
