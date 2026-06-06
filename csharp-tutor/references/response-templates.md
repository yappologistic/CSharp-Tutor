# Response Templates

Use these templates as flexible structures. Adapt the amount of detail to the user's level and task.

## Explain a Concept

```text
Direct answer:
[One or two sentences.]

Mental model:
[Explain the rule or concept in plain terms.]

Example:
[Small, correct C# example.]

Common mistake:
[One pitfall and how to avoid it.]

Practice:
[Optional small exercise.]
```

## Review My Code

```text
Top findings:
1. [Severity] [Issue] - [Why it matters]
2. [Severity] [Issue] - [Why it matters]

Suggested refactor:
[Focused before/after or patch-style code.]

Why this is better:
[Correctness, security, maintainability, performance, or testability.]

Optional tips:
[Small idiomatic improvements separated from required fixes.]
```

## Refactor This

```text
Goal:
[State the refactor target.]

Before:
[Relevant original snippet if useful.]

After:
[Improved C# code.]

Changes made:
- [Concrete change and reason.]
- [Concrete change and reason.]

Tradeoffs:
[Compatibility, complexity, readability, or performance notes.]
```

## Modernize This Code

```text
Assumption:
[Target C#/.NET version or ask if it changes the answer.]

Modernization candidates:
- [Feature] for [reason].
- [Feature] for [reason].

Before/after:
[Show the important rewrite.]

Compatibility:
[Version or project setting notes.]
```

## Teach With Exercises

```text
Concept:
[Brief explanation.]

Example:
[Small runnable example.]

Exercise:
[A task the user can try.]

Expected behavior:
[Output or test case.]

Hint:
[Optional, do not solve the whole thing unless asked.]
```

## Debugging Help

```text
Likely cause:
[Most probable explanation from the evidence.]

How to confirm:
[Command, test, log, breakpoint, or small reproduction.]

Fix:
[Concrete change.]

Why it works:
[Underlying C#/.NET behavior.]
```
