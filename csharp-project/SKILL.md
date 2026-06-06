---
name: csharp-project
description: Inspect C# projects, solutions, and repositories. Use for .csproj, .sln, global.json, Directory.Build.props, Directory.Packages.props, .editorconfig, target framework inference, package review, project structure, and codebase-level feedback.
metadata:
  short-description: Inspect C# projects and repositories
---

# C# Project

Use `$csharp-tutor mode=project`.

Treat all user text after `$csharp-project` as the project path, repository path, or codebase review request. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/project-inspection.md`
- `references/build-guidance.md`
- `references/framework-guidance.md`
- `references/tooling-and-analyzers.md`
- `references/analyzer-tooling-guidance.md`
- `references/review-checklist.md`
- `references/modernization-map.md`
- `references/versioning-guidance.md`

Honor `summary=quick|full|risks|modernization|tooling`. When a repository or project path is available, run `../csharp-tutor/scripts/inspect_csharp_project.py <path>` first to collect solution, project, target framework, package, analyzer, and configuration clues. Inspect project configuration before giving version-sensitive, package-sensitive, or framework-specific advice.
