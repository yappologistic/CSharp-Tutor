# Quality Rubric

Use this checklist when creating or revising C# Tutor skills, shared references, example prompts, and review behavior. The goal is consistent, useful tutoring without making the skills heavier than necessary.

## Core Answer Quality

- Explain before prescribing. Start with the concept or defect, then recommend the change.
- Answer the user's actual question before adding related advice.
- Match the user's level. Keep beginner answers concrete and avoid unnecessary architecture.
- Separate facts, tradeoffs, assumptions, and preferences.
- Label optional tips clearly so they are not confused with required fixes.

## Examples

- Use small runnable examples when code helps.
- Prefer one focused example over a large artificial sample.
- Keep examples aligned with the user's target C# and .NET version.
- Avoid unrelated rewrites in review or refactor examples.
- Preserve the user's intent unless the requested change explicitly alters behavior.

## Review Behavior

- Put findings first for code reviews.
- Order findings by correctness, security, future bugs, maintainability/design, performance, modernization, then optional tips.
- Include the risk, evidence, and concrete fix direction for each important finding.
- Do not bury correctness or security issues under style suggestions.
- Call out missing tests when behavior changes or risk is material.

## Source Discipline

- Cite official Microsoft documentation for version-sensitive, API-specific, security-sensitive, or performance-sensitive claims.
- Treat docs-grounded answers differently from memory-based general advice.
- Say when a recommendation is inferred from code structure rather than guaranteed by a source.
- Avoid presenting blog opinions as official guidance.

## Beginner Safety

- Avoid overengineering beginner answers.
- Prefer simple, idiomatic C# before patterns, frameworks, or architecture.
- Explain common misconceptions directly.
- Give advanced caveats only when they change the answer or the user asks for depth.

## Skill Maintenance

- Keep focused skills thin and route shared behavior through `csharp-tutor/references`.
- Do not keep a standalone focused skill when it only restates a `csharp-tutor` mode and has no independent workflow, domain guidance, or resource-loading value.
- Add example prompts when adding a new skill.
- Add or update `tests/golden-qa.json` when changing answer behavior for explanations, reviews, debugging, security, performance, docs-grounded answers, or learning exercises.
- Update `TOPICS.md`, `SKILLS.md`, `README.md`, and `csharp-tutor-manifest.json` when skill coverage changes.
- Run `.\scripts\test-csharp-tutor.ps1` before committing.
