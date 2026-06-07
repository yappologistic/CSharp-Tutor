# Modern .NET Patterns

Use this reference for C# 12/13-era language features, `Microsoft.Extensions.*` patterns, configuration, `HttpClient`, and channel-based coordination. Verify version availability with official docs before recommending a feature in production code.

## C# 12/13 Feature Heuristics

Recommend newer syntax only when it clarifies intent and the target language version supports it.

Useful candidates:

- Primary constructors for small dependency-bearing types.
- Collection expressions for concise literals.
- `required` members for initialization contracts.
- Records for immutable data and value-like DTOs.
- Pattern matching when it removes nested conditionals.

Avoid modernizing when:

- The project target or `LangVersion` is unknown and the feature is optional.
- The newer syntax hides important behavior from a beginner.
- A serializer, ORM, source generator, or public API depends on the existing shape.

Before:

```csharp
public sealed class ReportService
{
    private readonly IClock _clock;

    public ReportService(IClock clock)
    {
        _clock = clock;
    }
}
```

After when C# 12 is available:

```csharp
public sealed class ReportService(IClock clock)
{
    public DateTimeOffset Now => clock.GetUtcNow();
}
```

## Microsoft.Extensions Patterns

Prefer framework conventions for application infrastructure:

- `IOptions<T>` / `IOptionsMonitor<T>` for configuration-bound settings.
- `ILogger<T>` with structured templates, not interpolated log strings.
- `IHostedService` or `BackgroundService` for managed background work.
- `IHttpClientFactory` for named/typed `HttpClient` clients.
- DI lifetimes that match state ownership.

Bad:

```csharp
public sealed class BillingClient
{
    private readonly HttpClient _client = new();
}
```

Better:

```csharp
public sealed class BillingClient(HttpClient client)
{
    public Task<string> GetInvoiceAsync(string id, CancellationToken cancellationToken)
    {
        return client.GetStringAsync($"/invoices/{id}", cancellationToken);
    }
}
```

Register as a typed client:

```csharp
services.AddHttpClient<BillingClient>(client =>
{
    client.BaseAddress = new Uri("https://billing.example");
});
```

## Configuration and Options

Do not read arbitrary config values throughout the codebase. Bind once to a validated options type.

```csharp
public sealed class PaymentOptions
{
    public required string ApiBaseUrl { get; init; }
    public int TimeoutSeconds { get; init; } = 30;
}

services.AddOptions<PaymentOptions>()
    .BindConfiguration("Payment")
    .Validate(o => Uri.TryCreate(o.ApiBaseUrl, UriKind.Absolute, out _), "Payment:ApiBaseUrl must be absolute")
    .ValidateOnStart();
```

Use `IOptionsSnapshot<T>` for per-request reload behavior in web apps, `IOptionsMonitor<T>` for singleton/background services that need changes.

## HttpClient Guidance

Prefer `IHttpClientFactory` for app code. Always consider:

- Base address and relative URIs.
- Timeout and cancellation.
- Retry policy only for idempotent or explicitly safe operations.
- Avoid logging secrets in URLs or headers.
- Use typed clients when the API has cohesive behavior.

Response pattern:

```text
HttpClient issue: ...
Fix: ...
Why: ...
Check: add a test/fake handler for timeout, non-success status, and cancellation.
```

## Channels

Use `System.Threading.Channels` for in-process producer/consumer coordination when `Task.Run` plus shared collections becomes fragile.

Good fit:

- Bounded background work queues.
- Multiple producers and one or more consumers.
- Backpressure matters.

Not a good fit:

- Distributed queues.
- Durable jobs.
- Work that must survive process restart.

Small bounded queue:

```csharp
var channel = Channel.CreateBounded<Func<CancellationToken, ValueTask>>(new BoundedChannelOptions(100)
{
    FullMode = BoundedChannelFullMode.Wait
});

await channel.Writer.WriteAsync(workItem, cancellationToken);
```

Always plan completion, cancellation, exception logging, and backpressure behavior.
