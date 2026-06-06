# Source Citation Rules

Use this reference before finalizing answers that rely on current or precise C#/.NET facts.

## Citation Required

Prefer official Microsoft documentation, .NET API docs, C# language reference, official compatibility notes, official security guidance, or .NET source/reference material when answering about:

- C# language syntax, semantics, constraints, variance, nullable behavior, async behavior, LINQ behavior, or compiler diagnostics.
- .NET APIs, BCL behavior, ASP.NET Core, EF Core, dependency injection, serialization, security, performance, or version compatibility.
- Newer C# or .NET features, target-framework support, analyzer behavior, trimming, AOT, package guidance, or breaking changes.
- Security-sensitive, performance-sensitive, or production architecture recommendations.

## Response Rules

- If official sources were checked, include concise links or name the official source in the answer.
- If browsing or source lookup is unavailable, say what is based on general C#/.NET knowledge and what should be verified.
- Distinguish documented facts from inferred design advice.
- Do not cite unofficial blogs as primary authority for language rules, APIs, security, or compatibility.
- External resources may supplement examples or tradeoffs, but official docs should anchor correctness claims.
- For code reviews, cite only the important rules; do not clutter every minor comment with a link.

## Practical Standard

Use citations where they improve trust or prevent version mistakes. For simple beginner explanations, a short official-doc mention is enough unless the user asks for sources.
