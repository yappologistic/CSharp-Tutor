---
name: csharp-di
description: Teach and review dependency injection in C# and .NET. Use for service registration, constructor injection, lifetimes, scopes, factories, options, testability, dependency boundaries, inversion of control, ASP.NET Core DI, and maintainable object-oriented design.
metadata:
  short-description: C# dependency injection help
---

# C# DI

Use `$csharp-tutor mode=di`.

Treat all user text after `$csharp-di` as a C# dependency injection, service design, testability, OOP, or architecture question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/di-guidance.md`
- `references/modern-dotnet-patterns.md`
- `references/code-smell-to-refactor.md`
- `references/oop-guidance.md`
- `references/framework-guidance.md`
- `references/testing-guidance.md`
- `references/official-sources.md`

Prioritize lifetime correctness, explicit dependencies, replaceable boundaries, testability, and simple composition. Avoid adding interfaces or factories unless they solve a real coupling, lifetime, or testing problem.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete di decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the di concern.
- Minimal example: `services.AddScoped<IOrderService, OrderService>();`
