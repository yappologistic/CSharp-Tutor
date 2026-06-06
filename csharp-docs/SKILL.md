---
name: csharp-docs
description: Answer C# and .NET questions with strict official-doc grounding. Use when users ask for accurate, source-backed explanations, official Microsoft docs, version-sensitive behavior, API behavior, language rules, framework guidance, security guidance, compatibility, or citations.
---

# C# Docs

Use `$csharp-tutor mode=docs` or `$csharp-tutor explain-with-docs`.

Treat all user text after `$csharp-docs` as a docs-grounded C#/.NET question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/docs-grounding.md`
- `references/official-docs-map.md`
- `references/source-citation-rules.md`
- `references/official-sources.md`
- `references/verification-checklist.md`
- Topic-specific references such as `modernization-map.md`, `aspnet-guidance.md`, `efcore-guidance.md`, or `concurrency-guidance.md`

Honor confidence labels: `confidence=docs-verified`, `confidence=inferred`, and `confidence=needs-project-context`. Prefer official Microsoft sources. If official sources cannot be checked in the current environment, explicitly say which parts are general knowledge or inference and what should be verified.
