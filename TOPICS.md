# Topic Coverage

Use this map when deciding which skill owns a user request. Prefer the most focused skill when the topic is clear, and use `csharp-tutor` when the request spans several areas or the user wants general help.

## Common Goals

| User goal | Start with | Related skills |
| --- | --- | --- |
| Learn C# from scratch | `csharp-tutor` | `csharp-explain`, `csharp-practice`, `csharp-plan` |
| Explain a C# concept | `csharp-explain` | `csharp-tutor mode=docs`, `csharp-cheatsheets` |
| Review code quality | `csharp-tutor mode=review` | `csharp-refactor`, `csharp-tutor mode=style`, `csharp-tests` |
| Debug an error or failing test | `csharp-debug` | `csharp-errors`, `csharp-debug-lab` |
| Get the smallest fix for one error | `csharp-quickfix` | `csharp-debug`, `csharp-errors`, `csharp-analyzers` |
| Improve object-oriented design | `csharp-oop` | `csharp-refactor`, `csharp-design-patterns`, `csharp-architecture` |
| Modernize an old codebase | `csharp-modernize` | `csharp-versioning`, `csharp-tutor mode=style`, `csharp-tests` |
| Migrate between .NET versions | `csharp-migration` | `csharp-versioning`, `csharp-modernize`, `csharp-build` |
| Diagnose build or CI failures | `csharp-build` | `csharp-project`, `csharp-debug`, `csharp-versioning` |
| Improve application logging | `csharp-logging` | `csharp-aspnet`, `csharp-security`, `csharp-errors` |
| Create or publish a NuGet package | `csharp-nuget` | `csharp-api-design`, `csharp-versioning`, `csharp-build` |
| Check NativeAOT or trimming readiness | `csharp-aot` | `csharp-versioning`, `csharp-build`, `csharp-performance` |
| Containerize a .NET app | `csharp-containers` | `csharp-aspnet`, `csharp-aot`, `csharp-security` |
| Configure analyzers and warning policy | `csharp-analyzers` | `csharp-tutor mode=style`, `csharp-build`, `csharp-nullability` |
| Prepare for interviews | `csharp-interview` | `csharp-cheatsheets`, `csharp-practice`, `csharp-plan` |
| Inspect a C# repository | `csharp-project` | `csharp-architecture`, `csharp-versioning`, `csharp-tutor mode=review` |
| Get official-doc-backed guidance | `csharp-tutor mode=docs` | `csharp-versioning`, `csharp-tutor` |

## Language And Runtime Topics

| Topic | Primary skill | Related skills |
| --- | --- | --- |
| Async/await, `Task`, `ValueTask` | `csharp-async` | `csharp-concurrency`, `csharp-performance`, `csharp-tests` |
| Cancellation tokens | `csharp-async` | `csharp-api-design`, `csharp-tests` |
| Threads, locks, race conditions | `csharp-concurrency` | `csharp-async`, `csharp-performance` |
| LINQ and deferred execution | `csharp-linq` | `csharp-collections`, `csharp-efcore`, `csharp-performance` |
| Collections and lookup choices | `csharp-collections` | `csharp-linq`, `csharp-performance` |
| Generics, constraints, variance | `csharp-generics` | `csharp-api-design`, `csharp-collections` |
| Exceptions and validation | `csharp-errors` | `csharp-debug`, `csharp-api-design` |
| Nullable reference types | `csharp-nullability` | `csharp-tutor mode=style`, `csharp-errors`, `csharp-modernize`, `csharp-versioning` |
| Nullable reference type migration | `csharp-nullability` | `csharp-modernize`, `csharp-versioning`, `csharp-tutor mode=style` |
| Public API null contracts | `csharp-nullability` | `csharp-api-design`, `csharp-versioning`, `csharp-tutor mode=docs` |
| JSON serialization | `csharp-json` | `csharp-aspnet`, `csharp-errors` |
| Regex patterns and replacements | `csharp-regex` | `csharp-tests`, `csharp-performance`, `csharp-security` |
| Source generators | `csharp-sourcegen` | `csharp-analyzers`, `csharp-aot`, `csharp-json` |
| C# language version features | `csharp-versioning` | `csharp-modernize`, `csharp-tutor mode=docs` |
| Compiler and analyzer build failures | `csharp-build` | `csharp-debug`, `csharp-tutor mode=style`, `csharp-versioning` |
| Analyzer warnings and `.editorconfig` | `csharp-analyzers` | `csharp-tutor mode=style`, `csharp-nullability`, `csharp-build` |

## Framework And Project Topics

| Topic | Primary skill | Related skills |
| --- | --- | --- |
| ASP.NET Core APIs | `csharp-aspnet` | `csharp-security`, `csharp-di`, `csharp-tests` |
| Blazor components and apps | `csharp-blazor` | `csharp-aspnet`, `csharp-security`, `csharp-performance` |
| .NET MAUI apps | `csharp-maui` | `csharp-architecture`, `csharp-di`, `csharp-performance` |
| SignalR real-time apps | `csharp-signalr` | `csharp-aspnet`, `csharp-security`, `csharp-logging` |
| gRPC services and clients | `csharp-grpc` | `csharp-aspnet`, `csharp-api-design`, `csharp-security` |
| Entity Framework Core | `csharp-efcore` | `csharp-linq`, `csharp-performance`, `csharp-tests` |
| Dependency injection | `csharp-di` | `csharp-architecture`, `csharp-tests`, `csharp-aspnet` |
| Project files and target frameworks | `csharp-project` | `csharp-versioning`, `csharp-modernize` |
| Framework and runtime migrations | `csharp-migration` | `csharp-project`, `csharp-versioning`, `csharp-build` |
| SDK resolution, restore, and MSBuild | `csharp-build` | `csharp-project`, `csharp-versioning`, `csharp-debug` |
| NuGet package metadata and `dotnet pack` | `csharp-nuget` | `csharp-build`, `csharp-api-design`, `csharp-versioning` |
| NativeAOT, trimming, and publish settings | `csharp-aot` | `csharp-build`, `csharp-versioning`, `csharp-performance` |
| Docker and Kubernetes deployment | `csharp-containers` | `csharp-aot`, `csharp-aspnet`, `csharp-logging` |
| Public API design | `csharp-api-design` | `csharp-versioning`, `csharp-tutor mode=docs`, `csharp-tests` |
| Application architecture | `csharp-architecture` | `csharp-oop`, `csharp-di`, `csharp-tutor mode=review` |
| Design patterns | `csharp-design-patterns` | `csharp-oop`, `csharp-refactor`, `csharp-architecture` |

## Quality And Learning Topics

| Topic | Primary skill | Related skills |
| --- | --- | --- |
| Security review | `csharp-security` | `csharp-aspnet`, `csharp-tutor mode=review`, `csharp-tutor mode=docs` |
| Logging and production diagnostics | `csharp-logging` | `csharp-aspnet`, `csharp-security`, `csharp-errors` |
| Performance review | `csharp-performance` | `csharp-linq`, `csharp-efcore`, `csharp-async` |
| Test design and testability | `csharp-tests` | `csharp-tutor mode=review`, `csharp-refactor`, `csharp-debug` |
| Naming and formatting | `csharp-tutor mode=style` | `csharp-tutor mode=review`, `csharp-modernize` |
| Exercises and practice | `csharp-practice` | `csharp-debug-lab`, `csharp-plan` |
| Learning plans | `csharp-plan` | `csharp-practice`, `csharp-interview` |
| Quick references | `csharp-cheatsheets` | `csharp-help`, `csharp-tutor mode=docs` |
| Mixed-skill requests | `csharp-tutor` | `csharp-help`, `csharp-tutor mode=review`, `csharp-project` |
| Skill usage help | `csharp-help` | `csharp-tutor`, `SKILLS.md` |
