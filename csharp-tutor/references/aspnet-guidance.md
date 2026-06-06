# ASP.NET Core Guidance

Use this reference for ASP.NET Core controllers, minimal APIs, Razor Pages, middleware, hosting, auth, validation, configuration, logging, and web API design.

## First Checks

- Identify app style: minimal API, MVC controllers, Razor Pages, Blazor, worker service, or mixed app.
- Inspect `Program.cs`, route mapping, middleware ordering, authentication, authorization, validation, exception handling, and service registration.
- Verify current behavior against Microsoft ASP.NET Core docs before making version-sensitive claims.

## Review Priorities

1. Correct routing, model binding, validation, and status codes.
2. Authentication and authorization at endpoint and resource levels.
3. Middleware ordering, especially exception handling, routing, CORS, auth, rate limiting, and static files.
4. Safe input handling, output encoding, anti-forgery where relevant, and no secret leakage.
5. Async request handling with cancellation passed downstream.
6. DI lifetimes, options binding, configuration, logging, and environment-specific behavior.
7. Testability through integration tests, WebApplicationFactory, focused unit tests, and clear boundaries.

## Common Feedback

- Do not bind persistence entities directly to public request bodies; prefer request DTOs.
- Do not expose raw exception details to clients outside development.
- Check authorization against the specific resource being accessed.
- Avoid blocking calls, sync-over-async, or long CPU work on request threads.
- Keep controllers and endpoints thin enough to delegate business behavior to services.
- Use structured logging without logging secrets, tokens, passwords, or full sensitive payloads.

## Teaching Style

Explain the request pipeline as ordered middleware plus endpoint execution. For beginners, show a tiny route or controller example before discussing architecture. For production code, include a concrete test or verification step.
