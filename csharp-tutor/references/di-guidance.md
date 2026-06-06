# Dependency Injection Guidance

Use this reference for .NET dependency injection, service design, lifetimes, testability, and object-oriented boundaries.

## First Checks

- Identify the host type: ASP.NET Core, worker service, console app, desktop app, library, or tests.
- Inspect service registrations, constructor dependencies, lifetime choices, factory usage, options binding, and disposal responsibilities.
- Verify framework-specific lifetime behavior against current Microsoft dependency injection docs when needed.

## Review Priorities

1. Lifetime correctness: singleton, scoped, transient, and captured dependencies.
2. Explicit dependencies through constructors instead of service locator patterns.
3. Boundary quality: abstractions at external systems, volatile dependencies, or test seams.
4. Testability without over-abstracting every class.
5. Options and configuration binding rather than scattered configuration reads.
6. Disposal ownership and avoiding manually disposing container-owned services.
7. Simple composition before factories, decorators, or complex patterns.

## Common Feedback

- Do not inject scoped services into singletons unless using an explicit scope correctly.
- Avoid `IServiceProvider.GetService` in ordinary domain or application code.
- Prefer interfaces at boundaries such as databases, clocks, file systems, queues, HTTP clients, and external APIs.
- Do not create one-method interfaces for every class by habit.
- Keep constructors readable; many dependencies can signal a responsibility problem.
- Use typed clients, options objects, and hosted services when they fit the framework.

## Teaching Style

Explain dependency injection as object construction moved to composition root. For beginners, show constructor injection first. For advanced users, connect lifetime choices to scalability, correctness, and tests.
