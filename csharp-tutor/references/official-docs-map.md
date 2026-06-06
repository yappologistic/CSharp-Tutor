# Official Docs Map

Use this map to find canonical Microsoft Learn pages quickly before answering docs-grounded, version-sensitive, API-specific, security-sensitive, performance-sensitive, or framework-specific C#/.NET questions.

Prefer these links as starting points, not as a replacement for checking the user's code and project settings. For APIs, use the .NET API browser in addition to these conceptual pages.

## How To Use

- Start with the most specific topic link.
- Check "Applies to", target framework, package version, and article date when the advice is version-sensitive.
- Use "What's new" pages before recommending new C# or .NET features.
- Cite only the sources that support important claims.
- If a topic is not listed, search Microsoft Learn before using external sources.

## C# Language

| Topic | Official Link | Use For |
| --- | --- | --- |
| C# guide | https://learn.microsoft.com/en-us/dotnet/csharp/ | General C# concepts, language navigation, learning paths |
| C# language reference | https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/ | Syntax, operators, keywords, type behavior |
| C# language specification | https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/ | Precise language rules and edge cases |
| C# version history | https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-version-history | Feature availability by C# version |
| What's new in C# | https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/ | Current language feature updates |
| Nullable reference types | https://learn.microsoft.com/en-us/dotnet/csharp/nullable-references | Nullable annotations, null-state analysis, migration |
| Records | https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/types/records | Record classes, record structs, value equality, `with` expressions |
| Pattern matching | https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/patterns | `is`, `switch`, property/list/relational/logical patterns |
| Generics | https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/types/generics | Generic type parameters, reuse, constraints overview |
| Generic constraints | https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/constraints-on-type-parameters | `where` constraints and generic API design |
| Interfaces | https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/types/interfaces | Interface contracts, default interface members, implementation |
| Classes and structs | https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/object-oriented/ | OOP fundamentals, classes, structs, members |
| Exceptions | https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/exceptions/ | Exception basics, throw/catch/finally, exception design |
| LINQ overview | https://learn.microsoft.com/en-us/dotnet/csharp/linq/ | LINQ concepts, query syntax, method syntax |
| LINQ standard query operators | https://learn.microsoft.com/en-us/dotnet/csharp/linq/standard-query-operators/ | Filtering, projection, grouping, joins, ordering |

## Async, Concurrency, and Threading

| Topic | Official Link | Use For |
| --- | --- | --- |
| Async programming with async and await | https://learn.microsoft.com/en-us/dotnet/csharp/asynchronous-programming/ | Async mental model, `async`, `await`, task flow |
| Async scenarios | https://learn.microsoft.com/en-us/dotnet/csharp/asynchronous-programming/async-scenarios | I/O-bound vs CPU-bound async guidance |
| Async return types | https://learn.microsoft.com/en-us/dotnet/csharp/asynchronous-programming/async-return-types | `Task`, `Task<T>`, `ValueTask`, `async void` |
| Task asynchronous programming model | https://learn.microsoft.com/en-us/dotnet/standard/asynchronous-programming-patterns/task-based-asynchronous-pattern-tap | TAP conventions and task-based APIs |
| Cancellation in managed threads | https://learn.microsoft.com/en-us/dotnet/standard/threading/cancellation-in-managed-threads | `CancellationToken`, cooperative cancellation |
| Managed threading basics | https://learn.microsoft.com/en-us/dotnet/standard/threading/ | Threads, synchronization, managed threading concepts |
| Parallel programming | https://learn.microsoft.com/en-us/dotnet/standard/parallel-programming/ | TPL, PLINQ, CPU-bound parallelism |

## .NET Fundamentals and APIs

| Topic | Official Link | Use For |
| --- | --- | --- |
| .NET documentation | https://learn.microsoft.com/en-us/dotnet/ | .NET overview and doc navigation |
| .NET API browser | https://learn.microsoft.com/en-us/dotnet/api/ | Exact API behavior, overloads, exceptions, attributes |
| .NET fundamentals | https://learn.microsoft.com/en-us/dotnet/fundamentals/ | Runtime, libraries, diagnostics, deployment |
| What's new in .NET | https://learn.microsoft.com/en-us/dotnet/core/whats-new/ | New runtime, library, SDK, and tooling features |
| .NET target frameworks | https://learn.microsoft.com/en-us/dotnet/standard/frameworks | TFM compatibility and API availability |
| Configuration in .NET | https://learn.microsoft.com/en-us/dotnet/core/extensions/configuration | Configuration providers and options basics |
| Logging in .NET | https://learn.microsoft.com/en-us/dotnet/core/extensions/logging | Logging abstractions, providers, levels |
| Options pattern | https://learn.microsoft.com/en-us/dotnet/core/extensions/options | Strongly typed configuration and validation |
| Dependency injection overview | https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection/overview | Built-in DI concepts, registration, constructor injection |
| Dependency injection guidelines | https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection-guidelines | Lifetimes, disposal, service locator avoidance, container guidance |
| Worker services | https://learn.microsoft.com/en-us/dotnet/core/extensions/workers | Background services and hosted workers |
| Serialization with System.Text.Json | https://learn.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/overview | JSON serialization, deserialization, options |
| Date, time, and time zones | https://learn.microsoft.com/en-us/dotnet/standard/datetime/ | `DateTime`, `DateTimeOffset`, time zones |
| Globalization and localization | https://learn.microsoft.com/en-us/dotnet/core/extensions/globalization-and-localization | Culture, formatting, parsing, localization |

## ASP.NET Core

| Topic | Official Link | Use For |
| --- | --- | --- |
| ASP.NET Core docs | https://learn.microsoft.com/en-us/aspnet/core/ | ASP.NET Core overview and doc navigation |
| Minimal APIs | https://learn.microsoft.com/en-us/aspnet/core/fundamentals/minimal-apis | Minimal API routing, handlers, filters, binding |
| Controllers | https://learn.microsoft.com/en-us/aspnet/core/mvc/controllers/actions | MVC controllers and action design |
| Middleware | https://learn.microsoft.com/en-us/aspnet/core/fundamentals/middleware/ | Request pipeline order and middleware behavior |
| Routing | https://learn.microsoft.com/en-us/aspnet/core/fundamentals/routing | Endpoint routing and route matching |
| Model binding | https://learn.microsoft.com/en-us/aspnet/core/mvc/models/model-binding | Binding request data to parameters/models |
| Model validation | https://learn.microsoft.com/en-us/aspnet/core/mvc/models/validation | Validation attributes, model state, validation flow |
| Authentication overview | https://learn.microsoft.com/en-us/aspnet/core/security/authentication/ | Authentication schemes, challenge, forbid |
| Authorization overview | https://learn.microsoft.com/en-us/aspnet/core/security/authorization/ | Authorization concepts and policies |
| Simple authorization | https://learn.microsoft.com/en-us/aspnet/core/security/authorization/simple | `[Authorize]`, anonymous access, default behavior |
| Policy-based authorization | https://learn.microsoft.com/en-us/aspnet/core/security/authorization/policies | Requirements, handlers, reusable policies |
| Resource-based authorization | https://learn.microsoft.com/en-us/aspnet/core/security/authorization/resourcebased | Resource-specific authorization checks |
| Role-based authorization | https://learn.microsoft.com/en-us/aspnet/core/mvc/security/authorization/roles | Role checks and role policy guidance |
| ASP.NET Core security topics | https://learn.microsoft.com/en-us/aspnet/core/security/ | Security guidance index |
| ASP.NET Core error handling | https://learn.microsoft.com/en-us/aspnet/core/fundamentals/error-handling | Developer exception page, exception handler, problem details |
| ASP.NET Core logging | https://learn.microsoft.com/en-us/aspnet/core/fundamentals/logging/ | Logging in web apps |
| ASP.NET Core configuration | https://learn.microsoft.com/en-us/aspnet/core/fundamentals/configuration/ | App configuration sources and environment settings |
| HTTP requests with IHttpClientFactory | https://learn.microsoft.com/en-us/aspnet/core/fundamentals/http-requests | HttpClient factory, outgoing HTTP, resilience |

## Entity Framework Core

| Topic | Official Link | Use For |
| --- | --- | --- |
| EF Core overview | https://learn.microsoft.com/en-us/ef/core/ | EF Core concepts and doc navigation |
| DbContext lifetime/configuration | https://learn.microsoft.com/en-us/ef/core/dbcontext-configuration/ | Context lifetime, DI registration, unit-of-work scope |
| Modeling entity types | https://learn.microsoft.com/en-us/ef/core/modeling/entity-types | Entity configuration and model shape |
| Relationships | https://learn.microsoft.com/en-us/ef/core/modeling/relationships | Navigations, foreign keys, relationship mapping |
| Tracking vs no-tracking queries | https://learn.microsoft.com/en-us/ef/core/querying/tracking | Change tracking, identity resolution, read-only queries |
| Related data loading | https://learn.microsoft.com/en-us/ef/core/querying/related-data/ | `Include`, eager/explicit/lazy loading |
| Efficient querying | https://learn.microsoft.com/en-us/ef/core/performance/efficient-querying | Projection, pagination, indexes, split queries |
| Advanced performance topics | https://learn.microsoft.com/en-us/ef/core/performance/advanced-performance-topics | Context pooling, compiled queries, benchmarks |
| Client vs server evaluation | https://learn.microsoft.com/en-us/ef/core/querying/client-eval | LINQ translation boundaries |
| Raw SQL queries | https://learn.microsoft.com/en-us/ef/core/querying/sql-queries | `FromSql`, raw SQL safety and composition |
| Saving data | https://learn.microsoft.com/en-us/ef/core/saving/ | `SaveChanges`, inserts, updates, deletes |
| Transactions | https://learn.microsoft.com/en-us/ef/core/saving/transactions | Default transactions, manual transactions, savepoints |
| Concurrency conflicts | https://learn.microsoft.com/en-us/ef/core/saving/concurrency | Optimistic concurrency tokens and conflict handling |
| Migrations | https://learn.microsoft.com/en-us/ef/core/managing-schemas/migrations/ | Schema migrations and deployment flow |
| Nullable reference types in EF Core | https://learn.microsoft.com/en-us/ef/core/miscellaneous/nullable-reference-types | NRT behavior, required/optional properties |

## Testing and Tooling

| Topic | Official Link | Use For |
| --- | --- | --- |
| Unit testing C# with .NET CLI | https://learn.microsoft.com/en-us/dotnet/core/testing/unit-testing-with-dotnet-test | Test projects, `dotnet test`, test basics |
| xUnit with .NET CLI | https://learn.microsoft.com/en-us/dotnet/core/testing/unit-testing-csharp-with-xunit | xUnit project setup and examples |
| MSTest with .NET CLI | https://learn.microsoft.com/en-us/dotnet/core/testing/unit-testing-csharp-with-mstest | MSTest project setup and examples |
| NUnit with .NET CLI | https://learn.microsoft.com/en-us/dotnet/core/testing/unit-testing-csharp-with-nunit | NUnit project setup and examples |
| .NET CLI overview | https://learn.microsoft.com/en-us/dotnet/core/tools/ | `dotnet` commands and tooling |
| `dotnet build` | https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-build | Build behavior and common options |
| `dotnet test` | https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-test | Test command behavior and options |
| `dotnet format` | https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-format | Formatting and analyzer fixes |
| NuGet docs | https://learn.microsoft.com/en-us/nuget/ | Package management and restore |
| Central package management | https://learn.microsoft.com/en-us/nuget/consume-packages/central-package-management | `Directory.Packages.props` and package version centralization |
| Package vulnerability auditing | https://learn.microsoft.com/en-us/nuget/concepts/auditing-packages | NuGet package audit behavior |

## Security

| Topic | Official Link | Use For |
| --- | --- | --- |
| .NET security | https://learn.microsoft.com/en-us/dotnet/standard/security/ | .NET security overview |
| Secure coding guidelines | https://learn.microsoft.com/en-us/dotnet/standard/security/secure-coding-guidelines | Secure coding principles |
| Cryptography model | https://learn.microsoft.com/en-us/dotnet/standard/security/cryptography-model | Choosing and using cryptographic APIs |
| ASP.NET Core security | https://learn.microsoft.com/en-us/aspnet/core/security/ | Web security index |
| Data protection | https://learn.microsoft.com/en-us/aspnet/core/security/data-protection/ | ASP.NET Core data protection APIs |
| Prevent Cross-Site Scripting | https://learn.microsoft.com/en-us/aspnet/core/security/cross-site-scripting | XSS risks and output encoding guidance |
| Prevent Cross-Site Request Forgery | https://learn.microsoft.com/en-us/aspnet/core/security/anti-request-forgery | CSRF/antiforgery guidance |
| SameSite cookies | https://learn.microsoft.com/en-us/aspnet/core/security/samesite | Cookie SameSite behavior |
| Secret Manager | https://learn.microsoft.com/en-us/aspnet/core/security/app-secrets | Local development secrets |
| Azure Key Vault configuration provider | https://learn.microsoft.com/en-us/aspnet/core/security/key-vault-configuration | Production secret storage integration |

## Architecture and Modernization

| Topic | Official Link | Use For |
| --- | --- | --- |
| .NET Architecture Guides | https://dotnet.microsoft.com/en-us/learn/dotnet/architecture-guides | Microsoft-published architecture guidance |
| .NET microservices architecture | https://learn.microsoft.com/en-us/dotnet/architecture/microservices/ | Microservices, containers, cloud-native tradeoffs |
| Modernize .NET apps | https://learn.microsoft.com/en-us/dotnet/architecture/modernize-with-azure-containers/ | Modernization strategy and cloud/container migration |
| Native AOT deployment | https://learn.microsoft.com/en-us/dotnet/core/deploying/native-aot/ | AOT compatibility and deployment tradeoffs |
| Trimming options | https://learn.microsoft.com/en-us/dotnet/core/deploying/trimming/trim-self-contained | Trimming behavior and compatibility |

## Source Repositories

| Topic | Official Link | Use For |
| --- | --- | --- |
| dotnet/docs | https://github.com/dotnet/docs | Documentation source and issues |
| dotnet/runtime | https://github.com/dotnet/runtime | Runtime and BCL implementation details |
| dotnet/csharplang | https://github.com/dotnet/csharplang | C# language design notes and proposals |
| dotnet/aspnetcore | https://github.com/dotnet/aspnetcore | ASP.NET Core source and issues |
| dotnet/efcore | https://github.com/dotnet/efcore | EF Core source and issues |

## Search Patterns

Use these when the exact topic is missing:

```text
site:learn.microsoft.com/en-us/dotnet/csharp "topic"
site:learn.microsoft.com/en-us/dotnet/api "TypeName.MemberName"
site:learn.microsoft.com/en-us/aspnet/core "topic"
site:learn.microsoft.com/en-us/ef/core "topic"
site:learn.microsoft.com/en-us/dotnet/core/extensions "topic"
site:learn.microsoft.com/en-us/dotnet/standard/security "topic"
site:github.com/dotnet/runtime "TypeName"
site:github.com/dotnet/csharplang "feature name"
```
