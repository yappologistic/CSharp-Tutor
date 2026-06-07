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
- `references/skill-router.md`
- `references/self-update-guidance.md`
- `references/cross-skill-composition.md`

For normal help requests, present a concise guide:

- Most useful modes: explain, review, debug, lab, docs, cheatsheet, project, practice, next.
- Common aliases: `q`, `quiz`, `fix`, `docs`, `lab`, `cs`, `next`.
- Hints: `depth=quick|normal|deep`, `format=findings|before-after|checklist|mentor`, `scope=correctness|security|performance|architecture|tests`, `difficulty=easy|medium|hard`, `profile=beginner|production|security|performance`, `reveal=false`, `pasteable=true`.
- Focused controls: project `summary=risks`, API `contract=nullability`, docs `confidence=docs-verified`, practice `drill=linq`, interview `next-question`.
- Three to six examples.

Show the full command index only when the user asks for the full list.

When the user asks whether C# Tutor is up to date, how to update, how to reinstall, or how to check installed skills, read `references/self-update-guidance.md` and give the update, dry-run, and list-installed commands.

When a request spans several areas, recommend one primary skill plus supporting checks instead of listing every possible skill. Use `references/cross-skill-composition.md` for examples such as EF Core + async + performance or ASP.NET Core + security + logging.

Common help responses:

- "Which skill should I use?" -> read `references/skill-router.md`, name one best skill, give a one-line reason, and include one example prompt.
- "Show everything" -> summarize categories first, then show the full command index.
- "I have code but do not know what is wrong" -> suggest `csharp-tutor mode=review` for broad review or `csharp-debug` for failing behavior.
- "I just want the smallest fix" -> suggest `csharp-quickfix`.
- "Is this current?" -> use update guidance and avoid claiming remote state without checking.

If the user is trying to use slash commands, explain that this Codex UI exposes personal entries through Skills in the picker; selecting `C# Tutor` with a mode hint such as `mode=review` mirrors the GSD-style workflow.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete help decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the help concern.
- Minimal example: `@C# Tutor mode=review Review this class for correctness.`
