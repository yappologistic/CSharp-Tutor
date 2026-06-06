# Framework-Specific Guidance

Use this reference after identifying the application type. Verify framework-specific claims with current official docs.

## ASP.NET Core

- Check endpoint routing, model binding, validation, authentication, authorization, filters, middleware ordering, dependency injection lifetimes, configuration, logging, and error handling.
- Avoid blocking calls in request paths.
- Pass `CancellationToken` from requests into downstream async work.
- Validate request DTOs and avoid binding directly to persistence entities.
- Avoid leaking exception details to clients.
- Check authorization on resource access, not just endpoint access.
- Use framework security docs for auth, CORS, CSRF, headers, data protection, and rate limiting guidance.

## Entity Framework Core

- Check query translation, tracking behavior, N+1 queries, lazy loading surprises, transactions, concurrency tokens, migrations, and indexes.
- Prefer projection for read models instead of loading full entities.
- Use `AsNoTracking` for read-only queries when appropriate.
- Avoid calling client-side methods inside queries unless translation is known.
- Treat raw SQL as injection-sensitive and parameterize.
- Be careful with long-lived `DbContext` instances and dependency injection lifetimes.

## Desktop Apps

- Keep UI thread work responsive; move I/O and CPU work off the UI thread appropriately.
- Marshal UI updates back to the UI thread.
- Separate UI, state, and business logic enough to test behavior.
- Dispose subscriptions, timers, file handles, and unmanaged resources.
- Avoid putting credentials or sensitive data in client-side code.

## Libraries and APIs

- Design small public APIs with clear contracts, nullability annotations, cancellation support, and predictable exceptions.
- Avoid breaking public surface area casually.
- Consider binary/source compatibility, trimming, AOT, analyzers, XML docs, and package metadata.
- Do not capture application-specific dependencies deep in reusable libraries.
- Use `ConfigureAwait(false)` where appropriate in general-purpose library internals.

## Console Apps and Tools

- Validate command-line arguments and environment variables.
- Return useful exit codes.
- Separate parsing, business logic, and I/O.
- Make file paths, encodings, and culture explicit.
- Avoid printing secrets in diagnostic output.
