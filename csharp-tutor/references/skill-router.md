# C# Tutor Skill Router

Use this reference when the user does not know which focused C# skill to invoke. Match the user's intent, keywords, pasted error shape, code context, and desired outcome to the most likely skill. Prefer the smallest useful route, but keep `csharp-tutor` as the fallback for broad, mixed, exploratory, or beginner-level prompts.

## Routing Algorithm

1. Identify the user's requested outcome:
   - Learn or understand
   - Fix a concrete error
   - Review code
   - Refactor or improve design
   - Inspect a project
   - Make production behavior safer, faster, or easier to maintain
2. Look for domain words:
   - Frameworks: ASP.NET Core, EF Core, Blazor, MAUI, SignalR, gRPC
   - Tooling: build, restore, SDK, NuGet, analyzer, `.editorconfig`, Docker
   - Language areas: async, LINQ, generics, nullable, regex, source generator
   - Cross-cutting risks: security, performance, logging, tests, architecture
3. Select one primary skill. If two routes are plausible, choose the skill that owns the failure mode, not just the syntax involved.
4. Mention secondary skill context only when it changes the answer.
5. If the prompt has one compiler error, warning, exception, or tiny failing snippet and asks for the smallest fix, route to `csharp-quickfix` before deeper diagnostic skills.

## Fast Intent Map

| User intent or words | Primary skill | Secondary lens when useful |
| --- | --- | --- |
| "what is", "explain", "teach me", "how does this work" | `csharp-explain` | `csharp-docs` for version-sensitive facts |
| "give me exercises", "practice", "homework", "assignment" | `csharp-practice` | `csharp-debug-lab` for broken-code exercises |
| "learning path", "roadmap", "what should I learn next" | `csharp-plan` | `csharp-interview` for job prep |
| "interview", "mock interview", "coding drill" | `csharp-interview` | `csharp-cheatsheets` for review sheets |
| "cheat sheet", "quick reference", "summarize syntax" | `csharp-cheatsheets` | `csharp-docs` for official rules |
| "review this code", "is this good", "find issues" | `csharp-review` | `csharp-security` or `csharp-performance` for focused risk |
| "refactor", "clean up", "make this cleaner" | `csharp-refactor` | `csharp-oop` or `csharp-architecture` for design structure |
| "SOLID", "classes", "interfaces", "inheritance", "composition" | `csharp-oop` | `csharp-design-patterns` when naming a pattern |
| "architecture", "layers", "vertical slice", "modular", "scalable" | `csharp-architecture` | `csharp-di` for dependency boundaries |
| "strategy", "factory", "decorator", "repository", "unit of work" | `csharp-design-patterns` | `csharp-architecture` for system boundaries |
| "public API", "library API", "method signature", "binary compatibility" | `csharp-api-design` | `csharp-nuget` for package surface |
| "smallest fix", "just fix this", one compiler error or warning | `csharp-quickfix` | `csharp-debug` if symptoms are broader |
| "exception", "stack trace", "why does this fail", "debug" | `csharp-debug` | `csharp-errors` for error-handling redesign |
| "try/catch", "validation", "guard clause", "Result pattern" | `csharp-errors` | `csharp-api-design` for public error contracts |
| "unit test", "xUnit", "mock", "testability", "coverage" | `csharp-tests` | `csharp-di` for replaceable dependencies |
| "build failed", "restore failed", "SDK", "MSBuild", `.csproj`, CI failure | `csharp-build` | `csharp-project` for repo inspection |
| "analyzer", `.editorconfig`, "warning as error", "dotnet format" | `csharp-analyzers` | `csharp-style` for naming and formatting |
| "inspect my repo", "solution", `.sln`, "packages", "target framework" | `csharp-project` | `csharp-versioning` for compatibility |
| "async", "await", `Task`, cancellation token, deadlock, sync-over-async | `csharp-async` | `csharp-concurrency` for shared state or CPU work |
| "thread", "lock", "race condition", "parallel", `Channel`, shared state | `csharp-concurrency` | `csharp-performance` for throughput |
| "LINQ", `IEnumerable`, deferred execution, joins, grouping | `csharp-linq` | `csharp-performance` for repeated enumeration |
| "list", "dictionary", "hashset", "queue", "stack", data structure | `csharp-collections` | `csharp-performance` for lookup or allocation cost |
| "generic", type parameter, constraint, variance, `where T` | `csharp-generics` | `csharp-api-design` for reusable APIs |
| "nullable", `CS8602`, `CS8618`, null-forgiving `!` | `csharp-nullability` | `csharp-quickfix` for one warning |
| "regex", pattern, capture group, replacement, timeout | `csharp-regex` | `csharp-security` for ReDoS-sensitive input |
| "source generator", "incremental generator", generated code | `csharp-sourcegen` | `csharp-aot` for generator-based AOT support |
| "C# version", `LangVersion`, target framework, feature availability | `csharp-versioning` | `csharp-modernize` for refactor choices |
| "migrate", ".NET Framework", "upgrade to .NET", SDK-style project | `csharp-migration` | `csharp-versioning` for compatibility |
| "modernize", "newer C#", records, primary constructors, collection expressions | `csharp-modernize` | `csharp-versioning` for availability |
| "ASP.NET", "controller", "minimal API", middleware, routing, auth" | `csharp-aspnet` | `csharp-security` for web risk |
| "Blazor", Razor component, lifecycle, rendering mode, JS interop | `csharp-blazor` | `csharp-performance` for render cost |
| "MAUI", XAML, MVVM, binding, Shell navigation, mobile app | `csharp-maui` | `csharp-logging` for device diagnostics |
| "SignalR", hub, client, group, reconnect, real-time" | `csharp-signalr` | `csharp-aspnet` for hosting/auth |
| "gRPC", proto, service, streaming, deadline, status code | `csharp-grpc` | `csharp-api-design` for contract compatibility |
| "EF Core", DbContext, migration, tracking, Include, raw SQL | `csharp-efcore` | `csharp-performance` or `csharp-security` |
| "dependency injection", service lifetime, scoped, singleton, options | `csharp-di` | `csharp-tests` for testability |
| "JSON", serialization, deserialization, `System.Text.Json`, DTO | `csharp-json` | `csharp-aot` for source generation |
| "security", "vulnerability", SQL injection, path traversal, auth, secrets | `csharp-security` | Framework-specific skill for context |
| "performance", "slow", allocations, memory, throughput, benchmark" | `csharp-performance` | Domain skill for source of cost |
| "logging", `ILogger`, Serilog, structured logs, scopes, diagnostics | `csharp-logging` | `csharp-security` for secret-safe logs |
| "NuGet", package metadata, pack, publish, Source Link, symbols | `csharp-nuget` | `csharp-api-design` for package contracts |
| "Docker", container, compose, Kubernetes, image size, non-root | `csharp-containers` | `csharp-build` for publish failures |
| "NativeAOT", trimming, linker warning, single-file publish | `csharp-aot` | `csharp-json` or `csharp-sourcegen` |
| "official docs", "cite sources", "is this true in .NET X" | `csharp-docs` | Topic skill for the domain |

## Diagnostic Shape Routing

| Pasted shape | Route | Why |
| --- | --- | --- |
| `CS####` compiler diagnostic with one obvious file line | `csharp-quickfix` | The user likely needs the smallest edit first. |
| Multiple compiler errors after project or package changes | `csharp-build` | Build context and project configuration matter. |
| Runtime exception plus stack trace | `csharp-debug` | The task is diagnosis, not only syntax. |
| Nullable warning such as `CS8602`, `CS8604`, `CS8618` | `csharp-nullability` | Null contracts and flow analysis own the fix. |
| Failing unit test output | `csharp-tests` | The expected behavior and test design matter. |
| HTTP 400/401/403/404/500 in ASP.NET Core | `csharp-aspnet` | Routing, model binding, auth, middleware, or handlers own the failure. |
| EF query translation error or migration error | `csharp-efcore` | EF translation/model/migration rules own the failure. |
| Analyzer warning, formatting diff, or style rule failure | `csharp-analyzers` | Tooling configuration owns the outcome. |
| Publish failure mentioning trimming, AOT, or reflection | `csharp-aot` | Compatibility constraints own the fix. |
| Container build/run failure | `csharp-containers` | Dockerfile, publish output, ports, or runtime image owns the failure. |

## Ambiguous Requests

- "Improve this" -> start with `csharp-review`; if the code has a clear structural smell, route to `csharp-refactor`.
- "Make this production-ready" -> start with `csharp-review`; include `csharp-security`, `csharp-logging`, `csharp-tests`, and `csharp-performance` lenses as needed.
- "This is slow" -> route to `csharp-performance`, even if the code uses LINQ, EF Core, async, or collections.
- "This API is broken" -> route to `csharp-aspnet` unless the evidence is clearly build, JSON, auth, EF Core, or deployment.
- "Can I use this newer syntax?" -> route to `csharp-versioning` first, then `csharp-modernize` if the feature is available.
- "Is this safe?" -> route to `csharp-security`, even if the risky code is in ASP.NET Core, EF Core, JSON, files, or logging.
- "How do I structure this app?" -> route to `csharp-architecture`, not `csharp-oop`, unless the question is only about class relationships.
- "How do I mock this?" -> route to `csharp-tests`; use `csharp-di` only when the dependency boundary itself needs redesign.

## Handoff Format

When recommending a focused skill, use this shape:

```text
-> Use `$csharp-efcore` for this.
Handoff summary: Diagnose the failed migration and check DbContext/model configuration before suggesting code changes.
```

If the user asked a broad question and no focused route clearly dominates, answer with `csharp-tutor` directly and use the relevant references as support.
