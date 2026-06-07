# Answer Quality Rules

Use this reference before finalizing substantial explanations, code reviews, refactors, or security/performance feedback.

## Separate Categories

Make the response clear by separating:

- Facts from judgment or preference.
- Required fixes from optional tips.
- Correctness/security risks from style refinements.
- Beginner explanation from advanced notes when both are useful.
- Verified docs-backed claims from inferred advice.
- Compatibility constraints from recommended modernizations.

## Good vs Bad Answer Comparisons

### Debugging

Bad:

```text
This is probably null. Add a null check.
```

Better:

```text
Likely cause: `user.Address` can be null before `City` is read.

Smallest fix:
if (user.Address is null) return Results.BadRequest("Address is required.");

Why: the exception happens before your validation code can produce a normal error response.
```

### Code Review

Bad:

```text
This method is messy. Use clean code and SOLID.
```

Better:

```text
Main issue: `CreateOrder` validates input, calculates totals, writes to the database, and sends email.

Why it matters: a failure in email can now make order creation look like it failed.

First refactor: keep order creation transactional, then publish/send notification after the order is saved.
```

### Performance

Bad:

```text
LINQ is slow. Rewrite it as a loop.
```

Better:

```text
Do not rewrite this just because it uses LINQ. First check whether this is a hot path.

If it is hot, the concrete issue is multiple enumeration: `Count()` and `ToList()` both run the query. Materialize once or avoid the extra count.
```

### Security

Bad:

```text
This is insecure.
```

Better:

```text
Possible risk: path traversal. `relativePath` is user-controlled and can include `..`.

Safer pattern: normalize the combined path with `Path.GetFullPath`, then verify it still starts under the allowed root before reading.
```

## Source Discipline

- Cite official docs when the answer depends on language rules, framework behavior, security guidance, APIs, or version availability.
- Do not over-cite obvious beginner explanations.
- Do not present blog opinions as official guidance.
- Say when a recommendation is an inference from code structure rather than a documented rule.

## Code Examples

- Keep examples small and runnable when possible.
- Use idiomatic C# for the stated target version.
- Include `using` statements only when needed for clarity.
- Avoid unrelated rewrites in review examples.
- Preserve the user's intent unless explicitly changing behavior.

## Tone and Teaching

- Give the direct answer first.
- Explain the "why" behind important recommendations.
- Point out the main issue before minor improvements.
- Avoid overwhelming beginners with architecture unless the code truly needs it.
- For advanced users, be precise about tradeoffs and edge cases.

## Final Check

Before responding, ask:

- Did I answer the user's actual question?
- Did I account for target C#/.NET version when relevant?
- Did I identify the most important issue first?
- Did I separate optional tips from required fixes?
- Did I avoid unsupported performance or security claims?
- Did I provide a concrete fix, verification step, or next question?
