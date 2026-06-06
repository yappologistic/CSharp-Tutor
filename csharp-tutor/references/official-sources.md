# Official Sources

Use this reference to decide where to verify C# answers. Prefer current official sources before external material.

## Source Priority

1. Microsoft Learn C# documentation:
   - C# language reference
   - C# programming guide
   - C# language specification
   - What's new in C#
2. Microsoft Learn .NET documentation:
   - .NET API browser
   - .NET fundamentals
   - What's new in .NET
   - .NET security guidance
   - Secure coding guidelines
   - Framework-specific docs such as ASP.NET Core, Entity Framework Core, MAUI, or Windows desktop docs
3. Microsoft official repositories:
   - dotnet/runtime for runtime and BCL implementation details
   - dotnet/csharplang for language design notes and proposals
   - dotnet/docs and dotnet/AspNetCore.Docs for docs source
4. Trusted supplemental resources:
   - .NET Architecture Guides (`dotnet.microsoft.com/learn/dotnet/architecture-guides`) for Microsoft-published application architecture, cloud-native, microservices, and modernization guidance.
   - OWASP Cheat Sheet Series (`cheatsheetseries.owasp.org`) for practical secure coding guidance, especially the .NET Security Cheat Sheet and topic-specific sheets for authentication, authorization, input validation, logging, cryptographic storage, secrets, and error handling.
   - MITRE CWE (`cwe.mitre.org`) for naming and explaining weakness classes, root causes, and mitigations when discussing vulnerabilities or future security risks.
   - NuGet documentation (`learn.microsoft.com/nuget`) for package management, dependency behavior, package security, lock files, central package management, and publishing guidance.
5. External resources:
   - Use only when official docs are incomplete for teaching examples, ecosystem patterns, or comparative explanations.
   - Prefer reputable sources and clearly distinguish external practice from official guidance.

## Verification Rules

Verify with current official docs when answering about:

- Language syntax or semantics
- C# version-specific features
- .NET API behavior, overloads, attributes, exceptions, or thread-safety
- Nullable reference types
- Async, tasks, cancellation, parallelism, or threading
- LINQ behavior and deferred execution
- Memory management, spans, pooling, disposal, finalization, or performance
- ASP.NET Core, EF Core, dependency injection, configuration, logging, or hosting
- Security, cryptography, authentication, authorization, serialization, or networking
- Vulnerability mitigation, secure configuration, input handling, path handling, secret management, and logging guidance
- Recommended practices, obsolete APIs, or migration guidance
- Modernization guidance based on new C# or .NET releases

## Useful Search Patterns

Use targeted official-doc searches such as:

```text
site:learn.microsoft.com/dotnet/csharp "topic"
site:learn.microsoft.com/dotnet/csharp/whats-new "feature name"
site:learn.microsoft.com/dotnet/core/whats-new "feature name"
site:learn.microsoft.com/dotnet/api "TypeName.MemberName"
site:learn.microsoft.com/aspnet/core "topic"
site:learn.microsoft.com/dotnet/standard/security "topic"
site:learn.microsoft.com/aspnet/core/security "topic"
site:dotnet.microsoft.com/learn/dotnet/architecture-guides "topic"
site:cheatsheetseries.owasp.org "DotNet Security" "topic"
site:cwe.mitre.org "CWE" "topic"
site:learn.microsoft.com/nuget "topic"
site:github.com/dotnet/csharplang "feature name"
site:github.com/dotnet/runtime "TypeName"
```

## Supplemental Resource Use

Use supplemental resources to improve explanations and reviews, not to override official C# language or .NET API behavior.

- Use OWASP when reviewing web, API, authentication, authorization, cryptography, serialization, file upload, logging, secrets, dependency, or input-handling code.
- Use MITRE CWE when naming vulnerability categories or explaining why a pattern can become a weakness.
- Use .NET Architecture Guides when discussing scalable architecture, microservices, cloud-native patterns, modernization, or maintainability beyond a single code snippet.
- Use NuGet docs when feedback involves packages, dependency versions, transitive dependencies, package restore, or package security.

## Citation Habit

When sources were consulted, cite them briefly with links. Do not over-quote documentation. Summarize the rule in your own words, then show a small example.
