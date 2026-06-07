---
name: csharp-quickfix
description: Provide the smallest likely fix for a single C# compiler error, runtime exception, nullable warning, analyzer warning, syntax issue, type mismatch, missing using, missing package reference, async/await error, or small failing snippet with minimal explanation. Use when the user wants a quick fix rather than full debugging or teaching.
metadata:
  short-description: Smallest fix for one C# error
---

# C# Quickfix

Use `$csharp-tutor mode=quickfix`.

Treat all user text after `$csharp-quickfix` as one error, warning, exception, or small snippet that needs the smallest likely fix. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/quickfix-guidance.md`
- `references/compiler-error-library.md`
- `references/errors-guidance.md`
- `references/nullability-guidance.md`
- `references/analyzers-guidance.md`
- `references/build-guidance.md`

Default to a short answer: likely fix, minimal code or command change, and one-sentence why. If the issue needs logs, runtime state, multiple files, or deeper diagnosis, recommend `$csharp-debug` with a one-line handoff summary.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete quickfix decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the quickfix concern.
- Minimal example: `using System.Text.Json;`
