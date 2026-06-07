---
name: csharp-practice
description: Create C# practice exercises, assignments, mini projects, small projects, drills, hints, expected behavior, and review checklists for learners. Use for OOP, LINQ, async, concurrency, interfaces, classes, inheritance, generics, serialization, testing, interview drills, scenario-based learning, and beginner-friendly project ideas.
metadata:
  short-description: Create C# exercises and assignments
---

# C# Practice

Use `$csharp-tutor mode=practice`.

Treat all user text after `$csharp-practice` as the topic, level, project idea, or exercise request. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/exercise-guidance.md`
- `references/learner-levels.md`
- `references/response-templates.md`
- `references/example-prompts-and-responses.md`
- `references/interview-guidance.md`
- `references/mini-projects.md`
- `references/qol-command-ux.md`
- `references/example-quality-rules.md`

Honor `drill=string-parsing|collections|linq|oop-modeling|unit-tests|async|refactoring`, `difficulty=easy|medium|hard`, and `reveal=true|false`. Create runnable, level-appropriate exercises with expected behavior and hints. Do not solve the whole exercise unless asked.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete practice decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the practice concern.
- Minimal example: `static bool IsEven(int value) => value % 2 == 0;`
