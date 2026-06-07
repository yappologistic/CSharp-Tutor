---
name: csharp-architecture
description: Teach and review C# application architecture. Use for clean architecture, layered architecture, vertical slice architecture, domain services, application services, DTO boundaries, dependency direction, modularity, scalability, maintainability, testability, and avoiding overengineering.
metadata:
  short-description: C# architecture and structure help
---

# C# Architecture

Use `$csharp-tutor mode=architecture`.

Treat all user text after `$csharp-architecture` as a C# application architecture, maintainability, scalability, design-pattern, or dependency-boundary question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/architecture-guidance.md`
- `references/code-smell-to-refactor.md`
- `references/di-guidance.md`
- `references/framework-guidance.md`
- `references/testing-guidance.md`
- `references/source-citation-rules.md`

Prioritize clear responsibilities, dependency direction, testable boundaries, and incremental refactors. Avoid recommending architecture patterns unless they solve a concrete complexity, coupling, deployment, or scaling problem.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete architecture decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the architecture concern.
- Minimal example: `public sealed class CreateOrderHandler(IOrderRepository orders)`
