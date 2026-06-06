---
name: csharp-security
description: Review C# and .NET code for security risks and future vulnerabilities. Use for ASP.NET Core endpoints, auth, authorization, input validation, SQL injection, path traversal, serialization, cryptography, secrets, logging, dependencies, and package vulnerabilities.
metadata:
  short-description: Security review for C# and .NET
---

# C# Security

Use `$csharp-tutor mode=security`.

Treat all user text after `$csharp-security` as the code, endpoint, project, or security question to review. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/security-review-map.md`
- `references/logging-guidance.md`
- `references/analyzers-guidance.md`
- `references/official-sources.md`
- `references/verification-checklist.md`
- `references/framework-guidance.md`
- `references/tooling-and-analyzers.md`

Distinguish confirmed vulnerabilities from possible risks. Prefer official Microsoft, OWASP, MITRE CWE, and NuGet guidance for source-backed claims.
