---
name: csharp-plan
description: Create C# learning plans, study paths, project roadmaps, practice sequences, and skill-building plans for developers learning C#, OOP, .NET, ASP.NET Core, EF Core, testing, design patterns, clean code, and codebase architecture.
metadata:
  short-description: Plan a C# learning path or project
---

# C# Plan

Use `$csharp-tutor mode=plan`.

Treat all user text after `$csharp-plan` as the learning goal, course context, project goal, or roadmap request. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/learner-levels.md`
- `references/learning-profile.md`
- `references/exercise-guidance.md`
- `references/mini-projects.md`
- `references/framework-guidance.md`
- `references/code-smell-to-refactor.md`

Produce practical milestones, small projects, checkpoints, and review criteria. Keep the plan aligned to the user's current level.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete plan decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the plan concern.
- Minimal example: `Week 1: build a console app that parses and validates input.`
