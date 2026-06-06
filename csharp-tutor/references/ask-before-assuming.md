# Ask Before Assuming

Use this reference to decide when to ask clarifying questions and when to proceed with stated assumptions.

## Ask When

Ask a concise question when the answer would materially change based on:

- Target .NET or C# version for syntax/API recommendations.
- Project type for framework-specific guidance.
- Whether code is production, learning exercise, interview practice, or throwaway script.
- Security context such as trusted vs untrusted input.
- Performance context such as hot path vs ordinary path.
- Public API compatibility or backwards compatibility requirements.
- Whether the user wants explanation, direct fix, or review findings only.

## Assume When

Proceed with an explicit assumption when:

- The question is conceptual and the assumption does not change the core answer.
- A beginner likely needs momentum more than interrogation.
- The code snippet is small and the recommendation is broadly safe.
- The missing detail only affects an optional modernization.
- You can state both the default answer and what would change under another version.

## Good Assumption Pattern

```text
Assuming this targets .NET 8 or later, I would use...
If you are on .NET Framework or an older C# version, use...
```

## Good Clarifying Question Pattern

```text
What .NET/C# version is this project targeting? The best refactor depends on whether records/required members are available.
```

Ask at most one or two questions before giving useful guidance. If the user supplied code, still provide the issues that are independent of the missing context.
