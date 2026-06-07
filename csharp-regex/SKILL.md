---
name: csharp-regex
description: Teach, write, debug, and review regular expressions used from C#. Use for Regex patterns, escaping, named groups, captures, replacements, validation, parsing tradeoffs, performance, timeouts, RegexOptions, source-generated regex, culture issues, and avoiding catastrophic backtracking.
metadata:
  short-description: C# Regex help
---

# C# Regex

Use `$csharp-tutor mode=regex`.

Treat all user text after `$csharp-regex` as a C# regular expression learning, debugging, writing, review, or performance request. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/regex-guidance.md`
- `references/performance-review-map.md`
- `references/security-review-map.md`
- `references/testing-guidance.md`
- `references/sourcegen-guidance.md`
- `references/official-sources.md`

Ask for sample inputs and expected matches when missing. Prefer readable, bounded patterns with tests and timeouts over clever expressions.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete regex decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the regex concern.
- Minimal example: `Regex.Match(input, @"^\d{3}-\d{4}$", options, timeout);`
