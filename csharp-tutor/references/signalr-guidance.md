# SignalR Guidance

Use this reference for ASP.NET Core SignalR hubs, clients, real-time flows, and production review.

## Core Questions

- What messages flow between client and server?
- Does the app need user targeting, groups, broadcasts, or streaming?
- What should happen on reconnect?
- Are messages authenticated and authorized?
- Does the deployment require scale-out or Azure SignalR?

## Review Priorities

- Hub methods should validate input and enforce authorization server-side.
- Message contracts should be stable DTOs, not persistence entities.
- Groups are connection-scoped; rejoin logic may be needed after reconnect.
- Do not trust client-provided user IDs, group names, roles, or permissions.
- Avoid long blocking work inside hub methods.
- Use logging and correlation IDs for connection lifecycle debugging.
- Plan backpressure and message volume before broadcasting large payloads.

## Scaling Notes

Single-node assumptions break when multiple app instances handle connections. Ask about sticky sessions, backplanes, Azure SignalR, load balancers, and whether clients can tolerate missed or duplicate messages.

## Output Shape

For reviews, lead with correctness and production risks:

```text
Main issue: ...
Fix: ...
Why it matters: ...
Check: ...
```

Mention `csharp-aspnet`, `csharp-security`, or `csharp-logging` when the main issue is outside SignalR itself.
