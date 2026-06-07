---
name: csharp-design-patterns
description: Teach and review C# design patterns without overengineering. Use for strategy, factory, decorator, adapter, mediator, repository, unit of work, observer, command, dependency inversion, pattern selection, refactoring toward patterns, and deciding when not to use a pattern.
metadata:
  short-description: C# design pattern guidance
---

# C# Design Patterns

Use `$csharp-tutor mode=patterns`.

Treat all user text after `$csharp-design-patterns` as a C# design-pattern, refactoring, architecture, OOP, or maintainability question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/design-patterns-guidance.md`
- `references/architecture-guidance.md`
- `references/oop-guidance.md`
- `references/code-smell-to-refactor.md`
- `references/di-guidance.md`
- `references/testing-guidance.md`

Start from the concrete smell or variation point. Recommend a pattern only when it reduces real duplication, coupling, branching, construction complexity, or workflow complexity.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete design-patterns decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the design-patterns concern.
- Minimal example: `IDiscountPolicy policy = new HolidayDiscountPolicy();`
