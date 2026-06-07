# C# Skill Routing

Use this shared routing guide from every C# Tutor companion skill.

## Beginner-First Default

Default to beginner-friendly explanations unless the user asks for advanced depth or the code clearly requires production-level analysis.

- Explain terms before relying on them.
- Use small examples before abstractions.
- Separate required fixes from optional improvements.
- Prefer one clear path before listing many alternatives.
- Add advanced notes only when they change the decision.

## Routing Rules

- Use `csharp-explain` for concepts and syntax.
- Use `csharp-review` for general code feedback.
- Use `csharp-refactor` for structure, responsibilities, and clean code.
- Use `csharp-modernize` for newer C#/.NET features.
- Use `csharp-migration` for .NET Framework to modern .NET migrations, target framework upgrades, SDK-style conversion, package compatibility, and staged migration plans.
- Use `csharp-nullability` for nullable reference types, nullable warnings, null contracts, `!`, and null-safety migrations.
- Use `csharp-build` for `dotnet` build, restore, test, format, SDK, MSBuild, project-file, package restore, and CI build issues.
- Use `csharp-logging` for `ILogger`, structured logging, scopes, exception logging, Serilog basics, request logging, and safe production diagnostics.
- Use `csharp-nuget` for NuGet package creation, package metadata, `dotnet pack`, Source Link, symbols, package versioning, local package testing, and publishing safety.
- Use `csharp-aot` for NativeAOT, trimming, single-file publishing, linker warnings, reflection risks, serialization compatibility, and deployment constraints.
- Use `csharp-containers` for Dockerfiles, multi-stage builds, image size, non-root containers, health checks, compose, Kubernetes, and .NET container deployment.
- Use `csharp-analyzers` for Roslyn analyzers, `.editorconfig`, nullable warnings, warning levels, `TreatWarningsAsErrors`, `NoWarn`, `dotnet format`, and CI quality gates.
- Use `csharp-quickfix` for the smallest likely fix to one compiler error, exception, warning, syntax issue, or small failing snippet.
- Use `csharp-debug` for errors, exceptions, failing tests, and unexpected behavior.
- Use `csharp-security` for vulnerability and secure coding review.
- Use `csharp-performance` for speed, memory, allocations, and scale.
- Use `csharp-tests` for tests and testability.
- Use `csharp-project` for `.csproj`, `.sln`, package, and repo inspection.
- Use `csharp-practice` for exercises and assignments.
- Use `csharp-plan` for learning paths and project roadmaps.
- Use `csharp-style` for naming, formatting, `.editorconfig`, and idiomatic style.
- Use `csharp-oop` for classes, interfaces, inheritance, composition, SOLID, and patterns.
- Use `csharp-json` for serialization, deserialization, DTOs, records, and JSON persistence.
- Use `csharp-regex` for C# regular expressions, escaping, captures, replacement, validation, timeouts, and backtracking risks.
- Use `csharp-sourcegen` for Roslyn source generators, incremental generators, diagnostics, generated code, testing, and AOT-friendly generation.
- Use `csharp-async` for `async`/`await`, `Task`, cancellation, and async tests.
- Use `csharp-linq` for `IEnumerable<T>`, LINQ operators, deferred execution, joins, grouping, and query pitfalls.
- Use `csharp-errors` for exceptions, guard clauses, validation, result patterns, and error-handling design.
- Use `csharp-aspnet` for ASP.NET Core controllers, minimal APIs, middleware, routing, validation, auth, DI, and web APIs.
- Use `csharp-blazor` for Blazor components, lifecycle, state, rendering modes, forms, validation, JS interop, auth, and performance.
- Use `csharp-maui` for .NET MAUI, XAML, MVVM, binding, Shell navigation, platform-specific code, lifecycle, resources, packaging, and deployment.
- Use `csharp-signalr` for SignalR hubs, clients, groups, users, connection lifetime, reconnection, auth, scale-out, streaming, and diagnostics.
- Use `csharp-grpc` for .NET gRPC services, clients, proto contracts, streaming, deadlines, cancellation, auth, error mapping, compatibility, and diagnostics.
- Use `csharp-efcore` for Entity Framework Core, DbContext, migrations, LINQ translation, tracking, relationships, and data access.
- Use `csharp-di` for dependency injection, service lifetimes, scopes, factories, options, testability, and dependency boundaries.
- Use `csharp-generics` for generic classes, methods, interfaces, constraints, variance, type parameters, and type-safe reusable APIs.
- Use `csharp-collections` for arrays, lists, dictionaries, sets, queues, stacks, `IEnumerable`, equality comparers, mutation, ordering, and data structure choice.
- Use `csharp-architecture` for clean architecture, layered architecture, vertical slices, DTO boundaries, dependency direction, modularity, scalability, and testability.
- Use `csharp-concurrency` for threads, locks, synchronization, concurrent collections, channels, `Parallel`, race conditions, shared state, cancellation, and CPU-bound parallel work.
- Use `csharp-interview` for mock interviews, coding drills, concept questions, answer review, and C#/.NET interview study plans.
- Use `csharp-versioning` for C# language versions, .NET target frameworks, SDK defaults, `LangVersion`, package compatibility, trimming, AOT, modernization readiness, and feature availability.
- Use `csharp-design-patterns` for strategy, factory, decorator, adapter, mediator, repository, unit of work, observer, command, pattern selection, and deciding when not to use patterns.
- Use `csharp-docs` for official-doc-grounded C#/.NET explanations, citations, language rules, API behavior, framework behavior, security guidance, and compatibility.
- Use `csharp-debug-lab` for broken snippets, diagnosis-first debugging exercises, progressive hints, compiler errors, runtime exceptions, LINQ bugs, async bugs, nullability issues, and reveal-after-attempt solutions.
- Use `csharp-api-design` for public API design, method signatures, naming, nullability, exceptions, result types, cancellation, async APIs, DTOs, versioning, XML docs, and package surfaces.
- Use `csharp-cheatsheets` for compact C# topic summaries, syntax refreshers, quick references, and interview review sheets.

## Source and Verification

Use the main `csharp-tutor` references for detailed behavior. Use `cross-skill-composition.md` when the request spans multiple focused skills but one answer should cover the combined problem. Use `compiler-error-library.md` for compiler/runtime diagnostic triage and `code-smell-to-refactor.md` for maintainability/refactor guidance. Verify official C#/.NET behavior with Microsoft documentation when the answer depends on language rules, APIs, versions, security, performance, or production architecture. Use `docs-grounding.md` and `source-citation-rules.md` when citations or explicit uncertainty would improve trust. Use `qol-command-ux.md` to interpret aliases, depth, format, and reveal hints.
