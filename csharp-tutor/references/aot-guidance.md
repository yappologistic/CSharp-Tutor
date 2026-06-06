# AOT and Trimming Guidance

Use this reference for NativeAOT, trimming, single-file publishing, linker warnings, reflection risks, serialization compatibility, and deployment constraints.

## First Checks

- Identify the app type: console, worker, ASP.NET Core, library, desktop, plugin, or tool.
- Confirm target framework, runtime identifier, publish profile, and deployment target.
- Inspect `PublishAot`, `PublishTrimmed`, `SelfContained`, `PublishSingleFile`, `InvariantGlobalization`, and related project properties.
- Treat trim and AOT warnings as compatibility signals, not noise.

## Common Commands

```powershell
dotnet publish -c Release
dotnet publish -c Release -p:PublishTrimmed=true
dotnet publish -c Release -p:PublishAot=true
```

When diagnosing warnings, ask for the exact publish command and warning IDs.

## Common Risk Areas

- Reflection over unknown types or members.
- Dynamic assembly loading or plugin systems.
- Runtime code generation.
- Serialization that depends on reflection-discovered members.
- Dependency injection patterns that rely on dynamic activation.
- ORMs, proxies, expression compilation, or libraries without trimming/AOT annotations.
- Culture/globalization behavior changes in constrained deployments.

## Review Checklist

- Are publish settings explicit and appropriate for the app type?
- Are trim/AOT warnings fixed or justified?
- Are reflection and serialization paths annotated or source-generated where needed?
- Are dependencies known to support trimming or NativeAOT?
- Are startup, serialization, routing, and deployment paths tested from the published output?
- Is the user asking for performance, deployment size, startup time, or platform constraints?

## Response Pattern

1. State whether the issue is trimming, NativeAOT, single-file, runtime identifier, or dependency compatibility.
2. Identify the exact warning or publish setting involved.
3. Recommend the smallest safe change.
4. Suggest testing the published artifact, not only `dotnet build`.
5. Cite official docs for version-sensitive or warning-specific claims.
