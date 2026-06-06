# C# Tutor Skills

C# Tutor is a Codex skill collection for developers learning C# and improving C#/.NET code. It gives Codex focused instructions for docs-grounded explanations, code review, debugging help, refactoring guidance, architecture feedback, practice exercises, and project inspection.

The project is built around one main skill, `csharp-tutor`, plus focused companion skills such as `csharp-review`, `csharp-debug`, `csharp-async`, `csharp-oop`, `csharp-performance`, and `csharp-security`.

## What This Project Does

- Explains C# and .NET concepts with examples matched to the learner's level.
- Reviews snippets, files, projects, and repositories for correctness, maintainability, scalability, security, performance, tests, and modernization opportunities.
- Helps with OOP, SOLID, clean code, design patterns, architecture, API design, dependency injection, async, concurrency, LINQ, generics, collections, exceptions, JSON, ASP.NET Core, EF Core, and testing.
- Prefers official Microsoft documentation for language rules, .NET APIs, framework behavior, compatibility, security, and performance-sensitive claims.
- Provides learner support through practice exercises, debugging labs, cheat sheets, interview prep, mini projects, and learning plans.
- Includes shared catalogs for code smells/refactor choices and common compiler/runtime error triage.
- Includes a project inspection helper for `.csproj`, `.sln`, target frameworks, package references, analyzer settings, nullable settings, language version, and related project metadata.

## Requirements

- Codex with local skill support.
- Python 3 if you want to run the validation script or the C# project inspection helper.
- Git if you want to clone, version, or contribute to this repository.

## Installation

Install these skills by copying the skill folders into your Codex skills directory.

On Windows, the usual Codex skills directory is:

```text
%USERPROFILE%\.codex\skills
```

From this repository, copy all `csharp-*` folders into that directory:

```powershell
Copy-Item -Path "D:\CSharp-Tutor\csharp-*" -Destination "$env:USERPROFILE\.codex\skills" -Recurse -Force
```

If you cloned the repository somewhere else, run the command from the repository root:

```powershell
Copy-Item -Path ".\csharp-*" -Destination "$env:USERPROFILE\.codex\skills" -Recurse -Force
```

After copying the folders, restart Codex or start a new thread if the skill picker does not refresh immediately.

## Verifying Installation

After installation, the Codex skill picker should show entries such as:

- `C# Tutor`
- `Csharp Review`
- `Csharp Debug`
- `Csharp Project`
- `Csharp Async`
- `Csharp Oop`
- `Csharp Performance`
- `Csharp Security`

You can also type skill triggers in a prompt, for example:

```text
$csharp-tutor explain async and await in C#
$csharp-review review this class for clean code and maintainability
$csharp-debug help me understand this compiler error
```

## How To Use

Use `csharp-tutor` when you want the general tutor behavior:

```text
$csharp-tutor explain LINQ deferred execution with examples
$csharp-tutor review this code for OOP design and scalability
$csharp-tutor create a beginner practice exercise about generics
$csharp-tutor make me a 4-week plan for learning ASP.NET Core
```

Use focused skills when you know the type of help you want:

```text
$csharp-review review this service class for maintainability
$csharp-refactor improve this code using clean code principles
$csharp-debug explain why this NullReferenceException is happening
$csharp-async check this async code for cancellation and deadlock risks
$csharp-performance review this method for allocations and scalability
$csharp-security review this controller for security issues
$csharp-tests help me write unit tests for this class
```

For code review, paste the code directly into the prompt or work inside a project folder and point Codex at the relevant files.

## Command Hints

The main tutor skill supports lightweight command-style hints:

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

These hints are not a separate CLI. They are prompt conventions that help the skill choose the right response style.

## Skill List

Main skill:

- `csharp-tutor`: Core tutoring, routing, docs grounding, and shared references.

Focused companion skills:

- `csharp-api-design`: Public API design and compatibility.
- `csharp-architecture`: Application architecture guidance.
- `csharp-aspnet`: ASP.NET Core applications.
- `csharp-async`: Async, cancellation, and async API design.
- `csharp-cheatsheets`: Compact topic cheat sheets.
- `csharp-collections`: Collections and data structures.
- `csharp-concurrency`: Thread safety and CPU-bound parallelism.
- `csharp-debug`: Compiler errors, exceptions, failing tests, and unexpected behavior.
- `csharp-debug-lab`: Diagnosis-first debugging exercises.
- `csharp-design-patterns`: Pattern selection without overengineering.
- `csharp-di`: Dependency injection.
- `csharp-docs`: Official-doc-grounded C# and .NET answers.
- `csharp-efcore`: Entity Framework Core.
- `csharp-errors`: Exceptions, validation, and failure handling.
- `csharp-explain`: Concept explanations.
- `csharp-generics`: Generic types, methods, constraints, and variance.
- `csharp-help`: Concise usage help.
- `csharp-interview`: Mock interviews and answer review.
- `csharp-json`: JSON serialization and persistence.
- `csharp-linq`: LINQ and deferred execution.
- `csharp-modernize`: Version-aware modernization.
- `csharp-oop`: Object-oriented design.
- `csharp-performance`: Performance and scalability review.
- `csharp-plan`: Learning plans and roadmaps.
- `csharp-practice`: Exercises, drills, and assignments.
- `csharp-project`: Project and repository inspection.
- `csharp-refactor`: Clean code and design-focused refactoring.
- `csharp-review`: Code review and quality feedback.
- `csharp-security`: Secure coding review.
- `csharp-style`: Naming, formatting, analyzers, and style.
- `csharp-tests`: Test design and testability.
- `csharp-versioning`: C# and .NET compatibility checks.

## Project Layout

```text
D:\CSharp-Tutor
├── README.md
├── .gitignore
├── csharp-tutor
│   ├── SKILL.md
│   ├── agents
│   ├── references
│   └── scripts
└── csharp-*
    ├── SKILL.md
    └── agents
```

Most focused skills are thin adapters. Shared guidance lives in `csharp-tutor/references` so the skill family stays consistent. High-use references include the code smell catalog, compiler/runtime error library, review checklist, source citation rules, and project inspection guidance.

## Validation

Validate one skill with Codex's skill validator:

```powershell
python "$env:USERPROFILE\.codex\skills\.system\skill-creator\scripts\quick_validate.py" ".\csharp-tutor"
```

Validate every C# skill from the repository root:

```powershell
Get-ChildItem . -Directory -Filter "csharp*" |
  ForEach-Object {
    python "$env:USERPROFILE\.codex\skills\.system\skill-creator\scripts\quick_validate.py" $_.FullName
  }
```

Successful validation should report each skill as valid.

## Project Inspection Helper

`csharp-tutor/scripts/inspect_csharp_project.py` inventories C# project metadata such as solutions, project files, target frameworks, nullable settings, language version, package references, and likely test projects.

Example:

```powershell
python .\csharp-tutor\scripts\inspect_csharp_project.py "D:\Projects\MyApp" --pretty
```

This helper is useful when asking Codex to review a C# project because it gives the tutor a compact summary of the project structure before making recommendations.

## Documentation Policy

This repository contains skill instructions and references. It does not vendor Microsoft documentation.

The skills are designed to prefer official sources for:

- C# language behavior.
- .NET API behavior.
- ASP.NET Core and EF Core guidance.
- Version compatibility.
- Security-sensitive recommendations.
- Performance-sensitive recommendations.

External resources can be used when helpful, but official documentation should be treated as the primary source for claims that depend on current framework behavior.

## Contributing

When changing or adding a skill:

1. Keep focused skills small and route shared behavior through `csharp-tutor/references`.
2. Prefer official Microsoft documentation for technical claims.
3. Validate every changed skill before committing.
4. Avoid committing local paths, private project names, secrets, tokens, credentials, or machine-specific configuration.
5. Keep examples practical for developers who are learning C# and trying to write production-quality code.
