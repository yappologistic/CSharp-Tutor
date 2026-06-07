# Cross-Skill Composition

Use this reference when a request spans two or three focused skills, such as async + EF Core + performance, ASP.NET Core + security + logging, or migration + containers + AOT.

## Selection Protocol

Pick one primary skill and up to two supporting lenses:

1. Primary skill owns the user's concrete deliverable.
2. Supporting lenses add checks that materially change the answer.
3. Do not bounce the user between skills when one answer can cover the combined problem.

Examples:

- Slow async EF Core query -> primary `csharp-efcore`, supporting `csharp-async` and `csharp-performance`.
- ASP.NET endpoint leaking secrets in logs -> primary `csharp-security`, supporting `csharp-aspnet` and `csharp-logging`.
- .NET Framework API moving to containers -> primary `csharp-migration`, supporting `csharp-containers` and `csharp-build`.
- Blazor component with auth and rendering issues -> primary `csharp-blazor`, supporting `csharp-security` and `csharp-performance`.

## Response Shape

Use this structure for mixed-skill answers:

```text
Primary lens: <skill>
Supporting checks: <skill>, <skill>

Main answer:
...

Cross-checks:
- <supporting concern>
- <supporting concern>

Verify:
- ...
```

Keep supporting checks short. If a supporting concern becomes the main risk, switch the primary skill and say why.

## Escalation Rule

Recommend a separate focused follow-up only when:

- The secondary area needs its own code or project inspection.
- The answer would become too broad to be useful.
- The risks conflict and need a deliberate tradeoff decision.
