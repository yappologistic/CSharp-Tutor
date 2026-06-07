---
name: csharp-refactor
description: Refactor C# code for cleaner object-oriented design, better responsibilities, stronger encapsulation, SOLID, design patterns, testability, maintainability, scalability, and readable structure without unnecessary overengineering.
metadata:
  short-description: Refactor C# for OOP and clean code
---

# C# Refactor

Use `$csharp-tutor mode=refactor`.

Treat all user text after `$csharp-refactor` as the code or design problem to refactor. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/code-smell-to-refactor.md`
- `references/review-checklist.md`
- `references/testing-guidance.md`
- `references/learner-levels.md`
- `references/answer-quality-rules.md`

Preserve behavior unless the user requests behavior changes. Prefer simple, idiomatic C# before adding abstractions or patterns.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete refactor decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the refactor concern.
- Minimal example: `var total = CalculateSubtotal(items) + CalculateTax(items);`
