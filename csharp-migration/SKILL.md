---
name: csharp-migration
description: Plan and review C# and .NET migrations between target frameworks and app models. Use for .NET Framework to modern .NET, .NET Core or .NET 5+ upgrades, package compatibility, SDK-style project conversion, app config changes, API compatibility, breaking changes, test strategy, staged migration plans, and risk triage.
metadata:
  short-description: Plan C# and .NET migrations
---

# C# Migration

Use `$csharp-tutor mode=migration`.

Treat all user text after `$csharp-migration` as a migration planning, triage, or review request. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/migration-guidance.md`
- `references/versioning-guidance.md`
- `references/modernization-map.md`
- `references/project-inspection.md`
- `references/build-guidance.md`
- `references/testing-guidance.md`
- `references/official-sources.md`
- `references/source-citation-rules.md`

Start by identifying source framework, target framework, project type, dependencies, deployment constraints, and test coverage. Prefer staged, reversible migration plans over broad rewrites.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete migration decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the migration concern.
- Minimal example: `<TargetFramework>net8.0</TargetFramework>`
