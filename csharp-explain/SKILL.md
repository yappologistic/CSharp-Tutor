---
name: csharp-explain
description: Explain C# and .NET concepts for learners. Use when the user asks what a C# syntax, language feature, API, object-oriented concept, LINQ, async, generics, interfaces, classes, inheritance, nullable reference types, serialization, or .NET concept means or how it works.
metadata:
  short-description: Explain C# concepts with examples
---

# C# Explain

Use `$csharp-tutor mode=explain`.

Treat all user text after `$csharp-explain` as the concept, question, or code to explain. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/learner-levels.md`
- `references/response-templates.md`
- `references/official-sources.md`
- `references/docs-grounding.md`
- `references/source-citation-rules.md`
- `references/exercise-guidance.md`
- `references/cheatsheet-guidance.md`
- `references/example-quality-rules.md`

Answer with a direct explanation, a beginner-friendly mental model when appropriate, a small correct C# example, common mistakes, and a short practice task when useful.
