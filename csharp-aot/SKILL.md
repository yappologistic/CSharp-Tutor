---
name: csharp-aot
description: Teach and review C# and .NET NativeAOT, trimming, single-file publishing, linker warnings, reflection risks, serialization compatibility, source generators, publish settings, runtime identifiers, deployment constraints, and AOT/trimming readiness for apps and libraries.
metadata:
  short-description: .NET NativeAOT and trimming help
---

# C# AOT

Use `$csharp-tutor mode=aot`.

Treat all user text after `$csharp-aot` as the NativeAOT, trimming, publish, linker warning, reflection, serialization, dependency compatibility, deployment, or readiness question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/aot-guidance.md`
- `references/sourcegen-guidance.md`
- `references/containers-guidance.md`
- `references/versioning-guidance.md`
- `references/build-guidance.md`
- `references/performance-review-map.md`
- `references/project-inspection.md`
- `references/source-citation-rules.md`
- `references/official-sources.md`

Confirm target framework, app type, publish settings, and exact warnings before giving final advice. Treat trim and AOT warnings as design and compatibility feedback until proven otherwise.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete aot decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the aot concern.
- Minimal example: `<PublishAot>true</PublishAot>`
