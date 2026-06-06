---
name: csharp-debug-lab
description: Create C# debugging practice labs for learners. Use for broken snippets, compiler errors, runtime exceptions, LINQ bugs, async bugs, nullability issues, EF Core mistakes, hints, diagnosis-first exercises, step-by-step debugging practice, and reveal-after-attempt solutions.
---

# C# Debug Lab

Use `$csharp-tutor mode=debug-lab`.

Treat all user text after `$csharp-debug-lab` as a request for a C# debugging exercise, broken snippet, guided diagnosis, hint sequence, or debugging practice session. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/debug-lab-guidance.md`
- `references/common-csharp-pitfalls.md`
- `references/errors-guidance.md`
- `references/async-guidance.md`
- `references/linq-guidance.md`
- `references/testing-guidance.md`
- `references/qol-command-ux.md`

Honor `difficulty=easy|medium|hard`, `hint=1|2|3`, `reveal=true|false`, and `next_difficulty=true`. Give the learner the broken code and symptoms first. Do not reveal the fix immediately unless the user asks for it; offer progressive hints, then explain the root cause and corrected code after their attempt.
