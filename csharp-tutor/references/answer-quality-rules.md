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
