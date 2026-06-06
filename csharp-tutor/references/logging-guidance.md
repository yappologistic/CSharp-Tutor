# Logging Guidance

Use this reference for C# and .NET logging with `ILogger`, structured logging, scopes, Serilog basics, exception logging, and safe ASP.NET Core request logging.

## Core Principles

- Prefer structured logging over string interpolation so properties stay queryable.
- Use stable message templates with named placeholders:

```csharp
logger.LogInformation("Processed order {OrderId} for customer {CustomerId}", orderId, customerId);
```

- Pass exceptions as the first argument to logging methods that accept an exception:

```csharp
logger.LogError(ex, "Failed to process order {OrderId}", orderId);
```

- Do not log secrets, tokens, passwords, connection strings, personal data, or raw untrusted payloads unless they are explicitly sanitized and allowed by policy.
- Choose log levels based on operational meaning, not developer frustration.

## Log Levels

- `Trace`: very detailed diagnostic events, usually disabled in production.
- `Debug`: development and troubleshooting details.
- `Information`: normal meaningful application events.
- `Warning`: unexpected but handled conditions that may need attention.
- `Error`: failed operations that need investigation.
- `Critical`: process-wide or system-wide failures.

## Scopes And Context

- Use scopes to attach request, operation, tenant, or correlation context across multiple log entries.
- Prefer adding stable identifiers over verbose object dumps.
- In ASP.NET Core, rely on request logging and correlation IDs where available before adding duplicate logs.

## ASP.NET Core Notes

- Avoid logging request bodies by default.
- Do not log authorization headers, cookies, tokens, or credentials.
- Log validation failures at a level that matches operational value; common user mistakes are often not errors.
- Include route/action context or operation IDs when helpful for production support.

## Serilog Basics

- Serilog uses structured message templates. Keep placeholder names consistent.
- Prefer enrichers for cross-cutting properties such as environment, application, request ID, or user/tenant ID when policy allows.
- Avoid destructuring large or sensitive objects with `{@Object}` unless reviewed.

## Review Checklist

- Are logs structured rather than interpolated strings?
- Are exception logs preserving the exception object and stack trace?
- Are secrets and sensitive data excluded or sanitized?
- Are log levels meaningful and not too noisy?
- Are scopes or correlation IDs used for multi-step operations?
- Are logs useful for production diagnosis without exposing private data?
