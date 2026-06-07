# $csharp-tutor Recipes

Use this reference when the user explicitly invokes `$csharp-tutor` or asks what the skill can do through the `$` command.

## Supported Patterns

Users can invoke the skill with natural language:

```text
$csharp-tutor explain interfaces like I am a beginner
$csharp-tutor q topic=LINQ
$csharp-tutor cs topic=async
$csharp-tutor quiz topic=generics level=beginner
$csharp-tutor lab topic=nullability reveal=false
$csharp-tutor fix code="..."
$csharp-tutor review scope=security format=findings
$csharp-tutor review this code for OOP and clean code
$csharp-tutor refactor this method but keep it beginner-friendly
$csharp-tutor modernize this class for C# 12
$csharp-tutor debug this compiler error
$csharp-tutor async explain why .Result can be risky
$csharp-tutor linq explain IEnumerable and deferred execution
$csharp-tutor errors help me design validation and exceptions
$csharp-tutor aspnet review this minimal API for validation and authorization
$csharp-tutor efcore explain tracking vs no-tracking queries
$csharp-tutor di help me choose service lifetimes
$csharp-tutor generics explain constraints and variance
$csharp-tutor collections choose the right collection for fast lookup
$csharp-tutor architecture review this project structure for maintainability
$csharp-tutor concurrency review this shared state for race conditions
$csharp-tutor interview mock interview me on C# generics
$csharp-tutor versioning can I use collection expressions in this project?
$csharp-tutor patterns should I use strategy or factory here?
$csharp-tutor docs explain records vs classes with official sources
$csharp-tutor cheatsheet topic=LINQ format=table depth=quick
$csharp-tutor debug-lab topic="async" difficulty=easy reveal=false
$csharp-tutor api-design contract=nullability review this public method signature
$csharp-tutor tooling review my analyzer and .editorconfig setup
$csharp-tutor learning-profile create a plan for my level and goals
$csharp-tutor practice drill=linq difficulty=medium reveal=false
$csharp-tutor project summary=risks path="D:\Path\To\App.sln"
$csharp-tutor interview next-question
$csharp-tutor mini-project topic="EF Core inventory app" level=beginner
$csharp-tutor mode=review profile=production
$csharp-tutor explain-with-docs topic="records"
$csharp-tutor security review this ASP.NET Core endpoint
$csharp-tutor performance review this LINQ query
$csharp-tutor suggest tests for this service
$csharp-tutor inspect D:\Path\To\Project.csproj
$csharp-tutor make me exercises for inheritance and interfaces
```

Users can also provide lightweight mode hints:

```text
$csharp-tutor mode=explain level=beginner topic="interfaces vs abstract classes"
$csharp-tutor mode=review focus="security, async, OOP" path="D:\App\App.csproj"
$csharp-tutor mode=modernize target="C# 12, .NET 8" code="..."
$csharp-tutor mode=practice level=beginner topic="LINQ joins"
```

Do not require strict syntax. Treat hints as optional routing context, not a formal parser contract.

## Mode Routing

| Mode | Use When | Load |
| --- | --- | --- |
| `explain` | User asks what something means or how it works | `learner-levels.md`, `response-templates.md`, `official-sources.md` when facts matter |
| `review` | User shares code, files, or a project for feedback | `review-checklist.md`, relevant review maps |
| `refactor` | User wants cleaner OOP, maintainability, or design | `code-smell-to-refactor.md`, `testing-guidance.md` |
| `modernize` | User wants newer C#/.NET syntax or APIs | `modernization-map.md`, `project-inspection.md`, `official-sources.md` |
| `debug` | User has an error, exception, unexpected output, or failing test | `compiler-error-library.md`, `common-csharp-pitfalls.md`, `tooling-and-analyzers.md` |
| `async` | User asks about `async`/`await`, `Task`, cancellation, or async bugs | `async-guidance.md`, `common-csharp-pitfalls.md`, `testing-guidance.md` |
| `linq` | User asks about `IEnumerable<T>`, LINQ operators, deferred execution, joins, or grouping | `linq-guidance.md`, `common-csharp-pitfalls.md`, `performance-review-map.md` |
| `errors` | User asks about exceptions, guard clauses, validation, result patterns, or failure handling | `errors-guidance.md`, `compiler-error-library.md`, `common-csharp-pitfalls.md`, `review-checklist.md` |
| `aspnet` | User asks about ASP.NET Core, controllers, minimal APIs, middleware, routing, validation, auth, or web APIs | `aspnet-guidance.md`, `framework-guidance.md`, `security-review-map.md`, `testing-guidance.md` |
| `efcore` | User asks about Entity Framework Core, DbContext, migrations, LINQ translation, tracking, or data access | `efcore-guidance.md`, `framework-guidance.md`, `linq-guidance.md`, `performance-review-map.md` |
| `di` | User asks about dependency injection, service lifetimes, scopes, factories, options, or testability | `di-guidance.md`, `code-smell-to-refactor.md`, `oop-guidance.md`, `testing-guidance.md` |
| `generics` | User asks about generic types, methods, interfaces, constraints, variance, type parameters, or reusable APIs | `generics-guidance.md`, `official-sources.md`, `source-citation-rules.md` |
| `collections` | User asks about arrays, lists, dictionaries, sets, queues, stacks, IEnumerable, equality, ordering, mutation, or choosing data structures | `collections-guidance.md`, `linq-guidance.md`, `performance-review-map.md` |
| `architecture` | User asks about app structure, clean architecture, layers, vertical slices, DTO boundaries, dependency direction, modularity, scalability, or testability | `architecture-guidance.md`, `code-smell-to-refactor.md`, `di-guidance.md`, `testing-guidance.md` |
| `concurrency` | User asks about threads, locks, synchronization, concurrent collections, channels, Parallel, race conditions, shared state, or CPU-bound parallelism | `concurrency-guidance.md`, `async-guidance.md`, `performance-review-map.md`, `testing-guidance.md` |
| `interview` | User asks for mock interviews, coding drills, answer review, or C#/.NET interview prep | `interview-guidance.md`, `review-profiles.md`, `exercise-guidance.md`, `learner-levels.md` |
| `versioning` | User asks about C# language versions, .NET target frameworks, SDK defaults, LangVersion, package compatibility, trimming, AOT, or feature availability | `versioning-guidance.md`, `project-inspection.md`, `modernization-map.md`, `official-sources.md` |
| `patterns` | User asks about design patterns, pattern selection, refactoring toward a pattern, or whether a pattern is overengineering | `design-patterns-guidance.md`, `architecture-guidance.md`, `oop-guidance.md`, `code-smell-to-refactor.md` |
| `docs` | User asks for official-doc-backed C#/.NET explanation, citations, source-backed accuracy, API behavior, or language rules | `docs-grounding.md`, `source-citation-rules.md`, `official-sources.md`, topic-specific references |
| `cheatsheet` | User wants a compact topic summary, refresher, syntax sheet, or quick reference | `cheatsheet-guidance.md`, topic-specific references, `source-citation-rules.md` when facts are version-sensitive |
| `debug-lab` | User wants broken snippets, diagnosis-first exercises, progressive hints, or debugging practice | `debug-lab-guidance.md`, `compiler-error-library.md`, `common-csharp-pitfalls.md`, `errors-guidance.md`, topic-specific references |
| `api-design` | User asks about public API design, method signatures, nullability, exceptions, result types, cancellation, async signatures, DTOs, versioning, XML docs, or packages | `api-design-guidance.md`, `versioning-guidance.md`, `docs-grounding.md`, `testing-guidance.md` |
| `tooling` | User asks about analyzers, `.editorconfig`, nullable warnings, StyleCop, code metrics, dotnet format, package audit, or CI checks | `analyzer-tooling-guidance.md`, `tooling-and-analyzers.md`, `project-inspection.md` |
| `learning-profile` | User wants personalized ongoing tutoring, a roadmap, or exercises tailored to current level and goals | `learning-profile.md`, `learner-levels.md`, `exercise-guidance.md`, `mini-projects.md` |
| `next` | User asks what to learn next or wants a small diagnostic flow | `learning-profile.md`, `learner-levels.md`, `mini-projects.md`, `exercise-guidance.md` |
| `explain-with-docs` | User explicitly wants docs-grounded explanation or sources | `docs-grounding.md`, `source-citation-rules.md`, `official-sources.md`, topic-specific references |
| `security` | User asks about vulnerabilities or risky code | `security-review-map.md`, `official-sources.md` |
| `performance` | User asks about speed, allocations, memory, or scale | `performance-review-map.md`, `tooling-and-analyzers.md` |
| `test` | User asks for tests or testability feedback | `testing-guidance.md`, `response-templates.md` |
| `project` | User gives a repo, `.sln`, or `.csproj` path | `project-inspection.md`, `framework-guidance.md` |
| `practice` | User wants exercises, mini projects, or a learning assignment | `exercise-guidance.md`, `mini-projects.md`, `learner-levels.md` |
| `mini-project` | User wants scenario-based projects, milestones, portfolio practice, or practical assignments | `mini-projects.md`, `exercise-guidance.md`, `learner-levels.md` |
| `plan` | User wants a study path or project roadmap | `learner-levels.md`, `exercise-guidance.md`, `mini-projects.md`, `framework-guidance.md` when relevant |
| `style` | User asks about naming, formatting, idiomatic C#, `.editorconfig`, or style/readability conventions | `style-guidance.md`, `analyzers-guidance.md`, `tooling-and-analyzers.md`, `official-sources.md` when facts matter |

## Focus Hints

Recognize focus hints such as:

- `level=beginner|intermediate|advanced`
- `target=.NET 8|.NET 9|C# 12|C# 13`
- `focus=OOP|SOLID|security|performance|async|LINQ|nullability|tests|EF Core|ASP.NET Core`
- `output=short|thorough|checklist|before-after|exercise|assignment`
- `profile=beginner|production|architecture|security|performance|interview`
- `depth=quick|normal|deep`
- `format=findings|before-after|checklist|mentor|table`
- `reveal=true|false`
- `scope=correctness|security|performance|architecture|tests|all`
- `difficulty=easy|medium|hard`
- `summary=quick|full|risks|modernization|tooling`
- `contract=naming|nullability|errors|async|compatibility|docs`
- `confidence=docs-verified|inferred|needs-project-context`
- `pasteable=true|false`

Recognize aliases:

- `q` or `quick` means `depth=quick`.
- `quiz` means practice questions or interview-style drills.
- `fix` means debug or review based on whether code/error context is present.
- `docs` means `mode=docs`.
- `lab` means `mode=debug-lab`.
- `cs`, `sheet`, or `cheatsheet` means `mode=cheatsheet`.
- `next` means recommend the next learning step.

Honor the hint when it does not conflict with correctness or safety.

## Response Expectations

- For `explain`, teach first; avoid turning the answer into a code review unless code is provided.
- For `review`, findings first; order by correctness, security, design, performance, modernization, tips.
- For `refactor`, preserve behavior unless the user requests behavior changes.
- For `modernize`, check target version before using newer syntax.
- For `debug`, identify likely cause, how to confirm it, and the smallest fix.
- For `async`, explain the call flow and whether work is I/O-bound, CPU-bound, awaited, cancellable, or accidentally blocking.
- For `linq`, show the input sequence, query, execution point, output, and deferred execution or enumeration pitfall.
- For `errors`, separate compiler errors, runtime exceptions, validation failures, and expected business-rule failures.
- For `aspnet`, review request pipeline behavior, validation, auth boundaries, DI lifetimes, async request handling, and safe error responses.
- For `efcore`, distinguish LINQ-to-Objects from LINQ-to-Entities, check translation/tracking behavior, and avoid unsupported performance claims without generated SQL or measurement.
- For `di`, check lifetimes before design style, prefer explicit dependencies, and avoid adding abstractions unless they solve a real boundary or testing problem.
- For `generics`, explain type parameters and constraints in terms of compile-time guarantees before discussing advanced variance or API design.
- For `collections`, identify the access pattern first, then recommend the simplest collection that matches lookup, ordering, uniqueness, mutability, and enumeration needs.
- For `architecture`, tie every pattern suggestion to a concrete complexity, coupling, testability, deployment, or scaling problem.
- For `concurrency`, separate async I/O from thread-safety and CPU-bound parallelism, then identify shared state and synchronization boundaries.
- For `interview`, ask one question at a time unless the user asks for a list; after an answer, grade it and provide a stronger version.
- For `versioning`, inspect project files when available and separate language feature availability from BCL/API availability.
- For `patterns`, name the concrete design pressure before naming the pattern, and explain when not to use it.
- For `docs`, prefer official Microsoft docs, cite important claims, and separate documented facts from inference.
- For `cheatsheet`, keep it compact: core idea, syntax/API essentials, tiny example, common mistakes, when to use it, and one practice prompt.
- For `debug-lab`, show the broken code and symptom first; withhold the fix until the learner attempts or asks to reveal.
- For `api-design`, prioritize caller ergonomics, nullability, cancellation, errors, compatibility, and public contract clarity.
- For `tooling`, inspect project configuration first and keep analyzer recommendations sustainable rather than noisy.
- For `learning-profile`, ask only the few questions that materially improve the next response.
- For `next`, ask at most three profile questions if needed, then recommend the next two or three topics or one mini project.
- For `depth`, adjust detail without skipping correctness, safety, or necessary caveats.
- For `format`, honor the requested structure unless it would hide important risks.
- For `reveal=false`, withhold exercise/lab solutions and offer progressive hints first.
- For `explain-with-docs`, cite official Microsoft docs or explicitly say which claims are inferred and should be verified.
- For `profile`, load `review-profiles.md` and adapt priorities without ignoring correctness or safety.
- For `security`, distinguish confirmed vulnerabilities from possible risks.
- For `performance`, avoid unsupported claims; suggest measurement when needed.
- For `practice` and `mini-project`, include goal, requirements, constraints, expected behavior, hints, review checklist, and stretch goals.

## Examples

```text
$csharp-tutor mode=review focus="OOP, clean code" level=beginner
[paste code]
```

Respond with main issues, beginner-friendly explanation, a safe refactor direction, and optional tips.

```text
$csharp-tutor mode=project path="D:\Projects\BankApp\BankApp.csproj" focus="OOP, JSON persistence"
```

Inspect project files, infer target framework, review relevant code, then summarize issue clusters and next steps.

```text
$csharp-tutor mode=practice topic="interfaces" level=beginner output=assignment
```

Create a small assignment with goal, constraints, starter hints, expected behavior, and review checklist.
