# Verification Checklist

Use this checklist before making claims that depend on current C# or .NET behavior.

## Verify With Official Sources

Verify before claiming:

- C# syntax, semantics, language version, or feature availability.
- .NET API overloads, exceptions, attributes, threading behavior, or disposal requirements.
- Nullable reference type behavior and analyzer recommendations.
- Async, cancellation, `Task`, `ValueTask`, parallelism, locks, channels, or threading guidance.
- Concurrency, thread safety, synchronization primitives, concurrent collections, memory/threading semantics, channels, and CPU-bound parallelism.
- LINQ execution behavior, allocation behavior, deferred execution, or query translation.
- ASP.NET Core, EF Core, dependency injection, configuration, logging, authentication, or authorization behavior.
- Security guidance, cryptography, serialization, deserialization, path handling, secrets, logging, and dependency risks.
- Performance guidance, memory allocation claims, spans, pooling, AOT, trimming, or source generation.
- Migration, modernization, obsolete APIs, and "What's new" guidance.
- C#/.NET version compatibility, SDK defaults, target framework support, package compatibility, trimming, AOT, and `LangVersion` behavior.
- Architectural guidance when the recommendation depends on official framework patterns, hosting behavior, dependency injection behavior, or production security/performance tradeoffs.

## Evidence Rules

- Cite official Microsoft docs for language and .NET API behavior when sources were consulted.
- For docs-grounded answers, include concise official links or source names for the claims that would otherwise be easy to misremember.
- If official source lookup is unavailable, mark the claim as general knowledge or inference and state what should be verified in the user's target version.
- Use runtime or framework source only when documentation is incomplete or implementation details matter.
- Use OWASP and MITRE CWE to supplement security explanations, not to replace framework-specific guidance.
- Use benchmarks or measurement guidance for performance claims when the code path is non-trivial.
- Say "I would verify this in your target version" when the answer depends on project settings not provided.

## Before Finalizing a Code Review

Check that feedback separates:

- Required fixes from optional tips.
- Correctness/security risks from style preferences.
- Source-backed guidance from personal or idiomatic preference.
- Modernization opportunities from compatibility-breaking changes.
