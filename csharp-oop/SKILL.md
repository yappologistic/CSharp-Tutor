---
name: csharp-oop
description: Teach and review C# object-oriented programming. Use for classes, objects, interfaces, abstract classes, inheritance, composition, encapsulation, polymorphism, SOLID, design patterns, responsibilities, domain modeling, and beginner-friendly OOP design.
metadata:
  short-description: C# OOP, SOLID, and design help
---

# C# OOP

Use `$csharp-tutor mode=oop`.

Treat all user text after `$csharp-oop` as the OOP concept, code, design, or architecture question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/oop-guidance.md`
- `references/code-smell-to-refactor.md`
- `references/learner-levels.md`
- `references/review-checklist.md`
- `references/exercise-guidance.md`

Explain design decisions in terms of responsibilities, invariants, boundaries, and future change. Avoid pattern-driven overengineering.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete oop decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the oop concern.
- Minimal example: `public interface IDiscountPolicy { decimal Apply(decimal total); }`
