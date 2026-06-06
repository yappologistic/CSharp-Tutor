---
name: csharp-nuget
description: Teach and review C# NuGet package creation, packaging metadata, dotnet pack, semantic package versioning, local package testing, symbols, Source Link, package readmes/icons/licenses, private feeds, NuGet publishing safety, package compatibility, and .csproj package configuration.
metadata:
  short-description: C# NuGet package creation help
---

# C# NuGet

Use `$csharp-tutor mode=nuget`.

Treat all user text after `$csharp-nuget` as the package design, `.csproj` metadata, versioning, packing, local testing, private feed, Source Link, symbols, or publishing-safety question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/nuget-guidance.md`
- `references/api-design-guidance.md`
- `references/versioning-guidance.md`
- `references/build-guidance.md`
- `references/project-inspection.md`
- `references/tooling-and-analyzers.md`
- `references/official-sources.md`

Treat package publishing as compatibility-sensitive. Verify metadata, target frameworks, API surface, generated package contents, and publishing destination before recommending a public push.
