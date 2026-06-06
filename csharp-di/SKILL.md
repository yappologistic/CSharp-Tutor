---
name: csharp-di
description: Teach and review dependency injection in C# and .NET. Use for service registration, constructor injection, lifetimes, scopes, factories, options, testability, dependency boundaries, inversion of control, ASP.NET Core DI, and maintainable object-oriented design.
---

# C# DI

Use `$csharp-tutor mode=di`.

Treat all user text after `$csharp-di` as a C# dependency injection, service design, testability, OOP, or architecture question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/di-guidance.md`
- `references/code-smell-to-refactor.md`
- `references/oop-guidance.md`
- `references/framework-guidance.md`
- `references/testing-guidance.md`
- `references/official-sources.md`

Prioritize lifetime correctness, explicit dependencies, replaceable boundaries, testability, and simple composition. Avoid adding interfaces or factories unless they solve a real coupling, lifetime, or testing problem.
