# Migration Guidance

Use this reference for migrations between .NET target frameworks, project systems, runtime models, hosting models, and package ecosystems.

## First Questions

- What is the source target framework and project type?
- What is the desired target framework and why?
- Is this .NET Framework, .NET Core, or modern .NET?
- Which packages, runtime dependencies, OS assumptions, and deployment targets matter?
- What tests or manual smoke checks already protect behavior?

## Migration Strategy

Prefer staged migration:

1. Inventory projects, target frameworks, packages, build scripts, and deployment assumptions.
2. Make the current build reproducible.
3. Add or identify smoke tests before changing frameworks.
4. Move project files and package references in small batches.
5. Resolve API compatibility and package replacement issues.
6. Enable nullable, analyzers, trimming, or AOT only after the framework migration is stable.

## Common Risks

- .NET Framework APIs with no modern .NET equivalent.
- Transitive packages that do not support the target framework.
- `app.config` or `web.config` settings that move into modern configuration.
- ASP.NET MVC/Web API hosting assumptions that do not map directly to ASP.NET Core.
- Windows-only APIs, registry access, COM, GAC, remoting, WCF server dependencies, or legacy authentication.
- Silent behavior changes in serialization, globalization, HTTP, cryptography, or reflection.

## Output Shape

For migration plans, use:

```text
Target: <source> -> <target>
Main risks:
- ...
Plan:
1. ...
Validation:
- ...
Defer until after migration:
- ...
```

Separate framework migration from modernization. Newer syntax, nullable cleanup, and architecture refactors should usually be follow-up work unless required for compatibility.
