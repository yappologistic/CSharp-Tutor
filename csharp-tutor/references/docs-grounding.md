# Docs Grounding

Use this reference for source-backed C#/.NET answers.

## Official Source Order

Prefer:

1. Microsoft Learn C# language reference and language specification pages.
2. Microsoft Learn .NET API reference.
3. Official ASP.NET Core, EF Core, security, performance, compatibility, and deployment docs.
4. Official .NET blog or release notes for current feature announcements.
5. .NET runtime, Roslyn, ASP.NET Core, or EF Core source only when docs are incomplete or implementation details matter.

## Answer Structure

For docs-grounded answers:

1. Direct answer.
2. Confidence label.
3. Source-backed rule or behavior.
4. Small correct example.
5. Version or target-framework caveat.
6. What to verify in the user's project, if project context is missing.

## Confidence Labels

- `confidence=docs-verified`: official documentation, official source, or project files were checked for the key claim.
- `confidence=inferred`: answer is based on general C#/.NET knowledge and should not be presented as source-verified.
- `confidence=needs-project-context`: target framework, package version, SDK, `LangVersion`, nullable setting, provider, or runtime context is needed.

Use the label explicitly when the user asks for confidence or when the answer is version-sensitive.

## Citation Rules

- Cite only the sources that support important claims.
- Keep citations concise; do not turn every sentence into a citation.
- If a source was not checked, say so instead of implying official confirmation.
- Distinguish official behavior from design advice or inference.
- Use external sources only as secondary context when official docs are insufficient.

## Refusal To Overstate

If docs cannot be checked and the claim is version-sensitive, security-sensitive, or API-specific, answer with a caveat and a verification step instead of presenting the claim as settled.
