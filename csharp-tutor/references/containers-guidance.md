# Containers Guidance

Use this reference for Docker, container images, compose, Kubernetes, and containerized .NET deployment.

## Review Priorities

- Use multi-stage builds so SDK tools stay out of runtime images.
- Pin base images intentionally and update them through a known patch process.
- Run as non-root when possible.
- Keep configuration in environment variables, mounted secrets, or platform config, not baked into images.
- Add health checks that reflect app readiness and dependencies.
- Avoid copying the whole repository before restore when a narrower copy improves layer caching.
- Choose runtime image, ASP.NET image, chiseled image, Alpine, NativeAOT, or self-contained publish based on compatibility and operations needs.

## Dockerfile Checklist

- `COPY` project files before `dotnet restore` when optimizing cache.
- Use `dotnet publish` in the build stage.
- Copy only published output into the final stage.
- Set `ASPNETCORE_URLS` or app ports consistently with hosting platform expectations.
- Use `.dockerignore` to avoid copying build output, git metadata, secrets, and local artifacts.

## Kubernetes And Production

For Kubernetes or orchestrators, ask about:

- Readiness and liveness probes.
- Resource requests and limits.
- Graceful shutdown and cancellation.
- Secrets and config maps.
- Image tagging and rollback strategy.
- Logs to stdout/stderr and structured fields.

## Response Pattern

Give a corrected Dockerfile or deployment snippet only when enough project context is available. Otherwise give a short audit checklist and ask for the `.csproj`, app type, and current Dockerfile.
