---
name: csharp-versioning
description: Teach and review C# and .NET version compatibility. Use for C# language versions, .NET target frameworks, SDK defaults, LangVersion, nullable settings, implicit usings, package compatibility, trimming, AOT, modernization readiness, and questions like whether a C# or .NET feature can be used.
---

# C# Versioning

Use `$csharp-tutor mode=versioning`.

Treat all user text after `$csharp-versioning` as a C#/.NET version compatibility, modernization readiness, project configuration, or feature availability question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/versioning-guidance.md`
- `references/project-inspection.md`
- `references/modernization-map.md`
- `references/source-citation-rules.md`
- `references/official-sources.md`
- `references/tooling-and-analyzers.md`

Inspect project files when available before answering compatibility questions. Verify language and framework availability with official Microsoft docs before recommending newer syntax or APIs.
