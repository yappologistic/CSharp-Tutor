---
name: csharp-sourcegen
description: Teach and review C# source generators and incremental generators. Use for Roslyn generator basics, incremental pipelines, syntax providers, semantic models, generated files, diagnostics, analyzer packaging, testing, build performance, System.Text.Json source generation, AOT-friendly code generation, and generator debugging.
metadata:
  short-description: C# source generator help
---

# C# SourceGen

Use `$csharp-tutor mode=sourcegen`.

Treat all user text after `$csharp-sourcegen` as a C# source generator learning, debugging, design, review, or testing request. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/sourcegen-guidance.md`
- `references/analyzers-guidance.md`
- `references/aot-guidance.md`
- `references/json-guidance.md`
- `references/performance-review-map.md`
- `references/testing-guidance.md`
- `references/official-sources.md`

Prefer incremental generators for new work. Prioritize deterministic output, stable diagnostics, small semantic-model usage, testability, and build performance.
