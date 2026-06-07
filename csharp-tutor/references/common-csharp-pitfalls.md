# Common C# Pitfalls

Use this reference when reviewing code, debugging likely issues, or teaching habits that prevent defects. Prefer concrete fixes over generic warnings.

## Triage Heuristic

When reviewing a snippet, scan in this order:

1. Can it throw or fail for normal input?
2. Can async, disposal, or deferred execution change behavior after the method returns?
3. Can culture, time, equality, or shared state make it fail only in production?
4. Is a warning being suppressed instead of a contract being clarified?

## Nullability

Treat nullable warnings as design feedback, not noise. Prefer contracts that make invalid state hard to represent.

Bad:

```csharp
public sealed class UserDto
{
    public string Name { get; set; } = null!;
}
```

Better:

```csharp
public sealed class UserDto
{
    public required string Name { get; init; }
}
```

Use `!` only when a framework contract truly guarantees initialization and the reason is obvious. For external input, still validate:

```csharp
if (string.IsNullOrWhiteSpace(request.Name))
{
    return Results.BadRequest("Name is required.");
}
```

## Async

Do not block on async work. It can deadlock in context-bound apps and wastes request threads in server apps.

Bad:

```csharp
var user = userService.GetUserAsync(id).Result;
```

Better:

```csharp
var user = await userService.GetUserAsync(id, cancellationToken);
```

Rules:

- Avoid `async void` except event handlers.
- Await returned tasks or deliberately track/log background failures.
- Pass `CancellationToken` through I/O, request, and background boundaries.
- Use `ConfigureAwait(false)` mainly in library code where context capture is unnecessary.

## LINQ and Collections

Watch for multiple enumeration and the wrong lookup structure.

Bad:

```csharp
if (orders.Count() > 0)
{
    foreach (var order in orders)
    {
        Process(order);
    }
}
```

Better:

```csharp
var materialized = orders.ToList();
if (materialized.Count > 0)
{
    foreach (var order in materialized)
    {
        Process(order);
    }
}
```

For repeated membership checks:

```csharp
var allowedIds = allowedUsers.Select(u => u.Id).ToHashSet();
var visible = allUsers.Where(u => allowedIds.Contains(u.Id)).ToList();
```

Know whether a LINQ expression runs in memory or is translated by a provider such as EF Core. Provider-backed LINQ can fail at runtime or produce inefficient SQL.

## Time, Culture, and Text

Production bugs often come from local machine assumptions.

Bad:

```csharp
if (input.ToLower() == "admin")
{
    GrantAccess();
}
```

Better:

```csharp
if (string.Equals(input, "admin", StringComparison.OrdinalIgnoreCase))
{
    GrantAccess();
}
```

Guidelines:

- Prefer UTC, `DateTimeOffset`, or `TimeProvider` for cross-system logic.
- Specify `StringComparison` for non-linguistic comparisons.
- Use `CultureInfo.InvariantCulture` for machine-readable parse/format.
- Be explicit about file, stream, and network encodings.

## Exceptions and Error Handling

Do not catch broad exceptions unless adding handling, translation, cleanup, or context.

Bad:

```csharp
try
{
    Save(order);
}
catch (Exception ex)
{
    throw ex;
}
```

Better:

```csharp
try
{
    Save(order);
}
catch (DbUpdateException ex)
{
    throw new OrderSaveException(order.Id, ex);
}
```

If you are rethrowing the same exception, use `throw;` to preserve the original stack trace.

## Equality and Hashing

Hash keys must not change while stored in dictionaries or sets.

Bad:

```csharp
var key = new CustomerKey { Region = "EU", Id = 42 };
var cache = new Dictionary<CustomerKey, string> { [key] = "cached" };
key.Region = "US";
```

Better:

```csharp
public readonly record struct CustomerKey(string Region, int Id);
```

Override `Equals` and `GetHashCode` consistently, or use records for simple immutable value-like data when compatible.

## Shared State and Concurrency

Singletons and statics become risky when they hold per-request mutable state.

Bad:

```csharp
public sealed class CurrentUserCache
{
    public string? CurrentUserId { get; set; }
}
```

Registered as singleton, this leaks state between users.

Better:

```csharp
public sealed class CurrentUserContext
{
    public required string UserId { get; init; }
}
```

Register per request, pass explicitly, or make shared state immutable. Protect shared collections with locks, channels, or concurrent collections.

## Disposal and Resources

Do not return objects backed by disposed resources.

Bad:

```csharp
public Stream Open()
{
    using var file = File.OpenRead("data.bin");
    return file;
}
```

Better:

```csharp
public Stream Open()
{
    return File.OpenRead("data.bin");
}
```

Use `await using` for `IAsyncDisposable`, and dispose streams, database contexts, timers, subscriptions, and handles at the ownership boundary.
