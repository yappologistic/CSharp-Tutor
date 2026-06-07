---
name: csharp-logging
description: Teach and review C# and .NET logging. Use for ILogger, structured logging, message templates, log levels, scopes, correlation IDs, exception logging, Serilog basics, ASP.NET Core request logging, avoiding secrets or sensitive data in logs, and production diagnostics.
metadata:
  short-description: C# logging and ILogger help
---

# C# Logging

Use `$csharp-tutor mode=logging`.

Treat all user text after `$csharp-logging` as the logging concept, code review, ASP.NET Core logging question, Serilog question, security concern, or production diagnostics problem. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/logging-guidance.md`
- `references/modern-dotnet-patterns.md`
- `references/aspnet-guidance.md`
- `references/security-review-map.md`
- `references/errors-guidance.md`
- `references/performance-review-map.md`
- `references/official-sources.md`

Prefer structured logging and safe operational context. Treat secret leakage, sensitive data exposure, lost exception stack traces, and noisy production logs as higher priority than stylistic logging preferences.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete logging decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the logging concern.
- Minimal example: `logger.LogInformation("Processed order {OrderId}", orderId);`
