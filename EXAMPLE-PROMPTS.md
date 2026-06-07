# Example Prompts

Use these prompts as lightweight behavior examples when maintaining the skill pack. They are not exhaustive tests, but every skill should have at least one representative prompt here.

## Core

- `csharp-tutor`: `$csharp-tutor explain LINQ deferred execution to a beginner, then show a small runnable example.`
- `csharp-tutor`: `$csharp-tutor I have a dotnet restore failure in CI; recommend the best focused skill and give a one-line handoff summary.`
- `csharp-help`: `$csharp-help show me the best skill to use for reviewing async EF Core code.`
- `csharp-analyzers`: `$csharp-analyzers help me configure .editorconfig, nullable warnings, and TreatWarningsAsErrors without making style noise block CI.`
- `csharp-aot`: `$csharp-aot explain this trimming warning and show what code or project settings I should inspect first.`
- `csharp-migration`: `$csharp-migration plan a staged migration from .NET Framework 4.8 to .NET 8 and separate required fixes from modernization.`

## Review And Refactoring

- `csharp-review`: `$csharp-review review this service class for correctness, maintainability, tests, and performance risks.`
- `csharp-refactor`: `$csharp-refactor improve this method without changing behavior; explain the tradeoffs before the final version.`
- `csharp-style`: `$csharp-style review this class for naming, formatting, nullable warnings, and analyzer-friendly cleanup.`
- `csharp-modernize`: `$csharp-modernize suggest safe C# 12/.NET 8 improvements for this older codebase.`

## Debugging And Errors

- `csharp-debug`: `$csharp-debug help me diagnose this NullReferenceException from the stack trace and code.`
- `csharp-errors`: `$csharp-errors explain this compiler error and show the smallest correct fix.`
- `csharp-debug-lab`: `$csharp-debug-lab create a beginner debugging lab about a failing collection lookup, with hints hidden until I ask.`
- `csharp-quickfix`: `$csharp-quickfix fix this CS1503 error with the smallest code change and only one sentence of explanation.`

## Language Fundamentals

- `csharp-explain`: `$csharp-explain explain value types vs reference types with a simple memory model.`
- `csharp-oop`: `$csharp-oop review this inheritance design and suggest a simpler composition-based option if appropriate.`
- `csharp-generics`: `$csharp-generics explain generic constraints and variance using practical examples.`
- `csharp-collections`: `$csharp-collections compare List, Dictionary, and HashSet for lookup-heavy code.`
- `csharp-linq`: `$csharp-linq explain why this query executes twice and how to avoid accidental repeated enumeration.`
- `csharp-nullability`: `$csharp-nullability review these nullable warnings and show which fixes are real design fixes versus warning suppressions.`
- `csharp-regex`: `$csharp-regex write a C# regex for these sample inputs, show the captures, and include table-driven tests.`
- `csharp-async`: `$csharp-async review this async method for cancellation, sync-over-async, and deadlock risks.`
- `csharp-concurrency`: `$csharp-concurrency review this shared counter code for race conditions and thread-safety options.`

## Frameworks And Application Design

- `csharp-architecture`: `$csharp-architecture review this project structure for dependency direction and maintainability.`
- `csharp-api-design`: `$csharp-api-design review this public library API for binary compatibility, nullability, and async design.`
- `csharp-aspnet`: `$csharp-aspnet review this minimal API endpoint for validation, auth, errors, and testability.`
- `csharp-blazor`: `$csharp-blazor review this component lifecycle and state management for unnecessary renders and disposal bugs.`
- `csharp-build`: `$csharp-build diagnose this dotnet build failure and tell me whether it is SDK, restore, project file, compiler, or CI environment related.`
- `csharp-containers`: `$csharp-containers review this Dockerfile for a .NET API and suggest safer multi-stage build improvements.`
- `csharp-design-patterns`: `$csharp-design-patterns help me decide whether Strategy or a simple switch is better for this pricing logic.`
- `csharp-efcore`: `$csharp-efcore review this query for N+1 problems, tracking behavior, and projection opportunities.`
- `csharp-di`: `$csharp-di explain the correct lifetime for these services and how to test them.`
- `csharp-json`: `$csharp-json help me configure System.Text.Json for this DTO without breaking compatibility.`
- `csharp-logging`: `$csharp-logging review this ILogger usage for structured logging, exception handling, scopes, and secret leakage.`
- `csharp-nuget`: `$csharp-nuget review this .csproj package metadata and suggest a safe local package testing flow before publishing.`
- `csharp-signalr`: `$csharp-signalr review this hub for auth, groups, reconnect behavior, and scale-out assumptions.`
- `csharp-sourcegen`: `$csharp-sourcegen review this incremental generator pipeline for diagnostics, caching, and testability.`
- `csharp-versioning`: `$csharp-versioning check whether this project can safely move from .NET 6 to .NET 8.`

## Quality, Safety, And Learning

- `csharp-performance`: `$csharp-performance review this hot path for allocations and measurement strategy.`
- `csharp-security`: `$csharp-security review this controller for untrusted input, auth, secrets, and logging risks.`
- `csharp-tests`: `$csharp-tests help me design unit tests and edge cases for this parser.`
- `csharp-docs`: `$csharp-docs answer this C# language-version question using official Microsoft sources.`
- `csharp-cheatsheets`: `$csharp-cheatsheets make a compact async/await cheat sheet for interview review.`
- `csharp-practice`: `$csharp-practice create three exercises about interfaces, from beginner to intermediate.`
- `csharp-plan`: `$csharp-plan make a 4-week plan for learning ASP.NET Core after basic C#.`
- `csharp-interview`: `$csharp-interview run a mock C# interview focused on async, LINQ, and dependency injection.`
- `csharp-project`: `$csharp-project inspect this repository and summarize target frameworks, packages, nullable settings, and risks.`
