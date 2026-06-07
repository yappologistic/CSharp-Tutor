---
name: csharp-help
description: Show available C# Tutor skills, modes, examples, and usage guidance. Use when the user asks what C# Tutor can do, which C# skill to use, or how to invoke the C# Tutor skill family from the Codex picker.
metadata:
  short-description: Show C# Tutor commands and usage
---

# C# Help

Use `$csharp-tutor mode=help`.

Read these csharp-tutor references when useful:

- `references/qol-command-ux.md`
- `references/dollar-command-recipes.md`
- `references/command-index.md`
- `references/self-update-guidance.md`

For normal help requests, present a concise guide:

- Most useful modes: explain, review, debug, lab, docs, cheatsheet, project, practice, next.
- Common aliases: `q`, `quiz`, `fix`, `docs`, `lab`, `cs`, `next`.
- Hints: `depth=quick|normal|deep`, `format=findings|before-after|checklist|mentor`, `scope=correctness|security|performance|architecture|tests`, `difficulty=easy|medium|hard`, `profile=beginner|production|security|performance`, `reveal=false`, `pasteable=true`.
- Focused controls: project `summary=risks`, API `contract=nullability`, docs `confidence=docs-verified`, practice `drill=linq`, interview `next-question`.
- Three to six examples.

Show the full command index only when the user asks for the full list.

When the user asks whether C# Tutor is up to date, how to update, how to reinstall, or how to check installed skills, read `references/self-update-guidance.md` and give the update, dry-run, and list-installed commands.

If the user is trying to use slash commands, explain that this Codex UI exposes personal entries through Skills in the picker; selecting a focused C# skill such as `C# Review` mirrors the GSD-style workflow.
