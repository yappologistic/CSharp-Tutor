# C# Tutor Skills

C# Tutor is a Codex skill family for developers learning and improving C# and .NET code. It provides docs-grounded tutoring, code review, refactoring guidance, debugging help, practice exercises, project inspection, and focused guidance for common C# application areas.

The skills are designed to be used from the Codex skill picker or through prompts such as `$csharp-tutor mode=review`, `$csharp-async`, or `$csharp-project`.

## What It Does

- Explains C# and .NET concepts with examples tailored to the learner's level.
- Reviews snippets, files, projects, and repositories for correctness, security, maintainability, performance, tests, and modernization opportunities.
- Helps with OOP, SOLID, design patterns, architecture, API design, dependency injection, async, concurrency, LINQ, generics, collections, exceptions, JSON, ASP.NET Core, EF Core, and testing.
- Prefers official Microsoft documentation for language rules, APIs, framework behavior, compatibility, security, and performance-sensitive claims.
- Provides learning support through practice exercises, debugging labs, cheat sheets, interview prep, mini projects, and personalized learning profiles.
- Includes a project inspection helper for `.csproj`, `.sln`, target frameworks, package references, analyzer settings, and related project metadata.

## Skill Layout

The main skill is:

- `csharp-tutor`: Core tutoring, routing, and shared references.

Focused companion skills provide picker-friendly entry points:

- `csharp-review`: Code review and quality feedback.
- `csharp-debug`: Compiler errors, exceptions, failing tests, and unexpected behavior.
- `csharp-debug-lab`: Diagnosis-first debugging exercises.
- `csharp-explain`: Concept explanations.
- `csharp-docs`: Official-doc-grounded answers.
- `csharp-project`: Project and repository inspection.
- `csharp-modernize`: Version-aware modernization.
- `csharp-versioning`: C# and .NET compatibility checks.
- `csharp-tests`: Test design and testability.
- `csharp-practice`: Exercises, drills, and assignments.
- `csharp-cheatsheets`: Compact topic cheat sheets.
- `csharp-interview`: Mock interviews and answer review.
- `csharp-api-design`: Public API design and compatibility.
- `csharp-architecture`: Application architecture guidance.
- `csharp-design-patterns`: Pattern selection without overengineering.
- `csharp-oop`: Object-oriented design.
- `csharp-style`: Naming, formatting, analyzers, and style.
- `csharp-security`: Secure coding review.
- `csharp-performance`: Performance and scalability review.
- `csharp-async`: Async and cancellation.
- `csharp-concurrency`: Thread safety and CPU-bound parallelism.
- `csharp-linq`: LINQ and deferred execution.
- `csharp-generics`: Generic types, methods, constraints, and variance.
- `csharp-collections`: Collections and data structures.
- `csharp-errors`: Exceptions, validation, and failure handling.
- `csharp-json`: JSON serialization and persistence.
- `csharp-aspnet`: ASP.NET Core applications.
- `csharp-efcore`: Entity Framework Core.
- `csharp-di`: Dependency injection.
- `csharp-plan`: Learning plans and roadmaps.
- `csharp-help`: Concise usage help.

## Quality-Of-Life Hints

The main skill supports lightweight hints and aliases:

```text
$csharp-tutor q topic=LINQ
$csharp-tutor cs topic=async
$csharp-tutor quiz topic=generics level=beginner
$csharp-tutor lab topic=nullability reveal=false
$csharp-tutor review scope=security format=findings
$csharp-tutor cheatsheet topic=LINQ format=table depth=quick
$csharp-tutor project summary=risks path="D:\Projects\App\App.csproj"
```

Common controls:

- `depth=quick|normal|deep`
- `format=findings|before-after|checklist|mentor|table`
- `scope=correctness|security|performance|architecture|tests|all`
- `difficulty=easy|medium|hard`
- `reveal=true|false`
- `pasteable=true|false`
- `profile=beginner|production|architecture|security|performance|interview`

## Installation

Copy the desired skill folders into your Codex skills directory. For a full install, copy all `csharp-*` folders.

Typical Windows location:

```text
%USERPROFILE%\.codex\skills
```

After copying, restart Codex or start a new thread if the skill picker does not refresh immediately.

## Validation

Validate a skill with Codex's skill validator:

```powershell
python "$env:USERPROFILE\.codex\skills\.system\skill-creator\scripts\quick_validate.py" ".\csharp-tutor"
```

To validate every copied C# skill:

```powershell
Get-ChildItem . -Directory -Filter "csharp*" |
  ForEach-Object {
    python "$env:USERPROFILE\.codex\skills\.system\skill-creator\scripts\quick_validate.py" $_.FullName
  }
```

## Project Inspection Helper

`csharp-tutor/scripts/inspect_csharp_project.py` inventories C# project metadata such as solutions, project files, target frameworks, nullable settings, language version, package references, and likely test projects.

Example:

```powershell
python .\csharp-tutor\scripts\inspect_csharp_project.py "D:\Projects\MyApp" --pretty
```

## Notes

- This repository contains skill instructions and references. It does not vendor Microsoft documentation.
- The skills are intended to prefer official Microsoft sources for version-sensitive, API-specific, security-sensitive, and performance-sensitive answers.
- Focused skills are intentionally thin adapters. Shared behavior belongs under `csharp-tutor/references`.
