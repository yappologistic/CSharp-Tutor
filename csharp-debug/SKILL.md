---
name: csharp-debug
description: Debug C# compiler errors, runtime exceptions, failing tests, unexpected behavior, async issues, nullability problems, LINQ mistakes, serialization bugs, project build errors, and .NET tooling failures.
metadata:
  short-description: Debug C# errors and failing behavior
---

# C# Debug

Use `$csharp-tutor mode=debug`.

Treat all user text after `$csharp-debug` as the error, failing code, stack trace, test failure, or debugging goal. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/common-csharp-pitfalls.md`
- `references/quickfix-guidance.md`
- `references/compiler-error-library.md`
- `references/build-guidance.md`
- `references/debug-lab-guidance.md`
- `references/tooling-and-analyzers.md`
- `references/analyzer-tooling-guidance.md`
- `references/project-inspection.md`
- `references/testing-guidance.md`
- `references/response-templates.md`

Give the likely cause, how to confirm it, the smallest fix, and why the fix works.
