---
name: csharp-tests
description: Help write, review, and improve C# tests. Use for xUnit, NUnit, MSTest, unit tests, integration tests, async tests, testability refactors, TimeProvider, dependency boundaries, mocks, characterization tests, and regression coverage.
metadata:
  short-description: Improve C# tests and testability
---

# C# Tests

Use `$csharp-tutor mode=test`.

Treat all user text after `$csharp-tests` as the behavior, code, test failure, or testability question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/testing-guidance.md`
- `references/tooling-and-analyzers.md`
- `references/review-checklist.md`
- `references/response-templates.md`

Recommend the smallest useful test level, representative test names or skeletons, and why the test catches the issue.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete tests decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the tests concern.
- Minimal example: `Assert.Equal("paid", invoice.Status);`
