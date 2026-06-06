# Contributing

This repository is a Codex skill pack, so small wording changes can affect how the tutor behaves. Prefer narrow, easy-to-review changes and keep shared behavior in `csharp-tutor/references` when more than one focused skill needs it.

## Local Checks

Run the full repository health check before committing:

```powershell
.\scripts\test-csharp-tutor.ps1
```

If Codex's local skill validator is unavailable on your machine, run:

```powershell
.\scripts\test-csharp-tutor.ps1 -SkipSkillValidation
```

Regenerate the skill catalog after changing a skill description, package version, or manifest skill list:

```powershell
.\scripts\generate-skills-catalog.ps1
```

## Adding Or Changing Skills

1. Keep each focused `csharp-*` skill small.
2. Put reusable teaching, review, debugging, or versioning behavior in `csharp-tutor/references`.
3. Add the skill folder name to `csharp-tutor-manifest.json`.
4. Keep `SKILL.md` frontmatter `name` exactly aligned with the folder name.
5. Add or update example prompts in `EXAMPLE-PROMPTS.md`.
6. Run `.\scripts\generate-skills-catalog.ps1`.
7. Run `.\scripts\test-csharp-tutor.ps1`.

## Skill Quality Bar

- Explain the core idea before advanced caveats unless the user asks for depth.
- Prefer runnable, minimal C# examples over large artificial samples.
- Call out common beginner misconceptions.
- Separate required fixes from optional quality-of-life tips.
- Use official Microsoft documentation for version-sensitive, API-specific, security-sensitive, or performance-sensitive claims.
- For code review skills, lead with findings ordered by severity before general suggestions.

## Release Process

Prepare version metadata:

```powershell
.\scripts\release.ps1 -Version 0.5.1
```

Create and push a release tag after checks pass:

```powershell
.\scripts\release.ps1 -Version 0.5.1 -CreateTag -PushTag
```
