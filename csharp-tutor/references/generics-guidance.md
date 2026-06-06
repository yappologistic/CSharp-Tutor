# Generics Guidance

Use this reference for C# generic types, methods, interfaces, constraints, variance, reusable APIs, and generic compiler errors.

## Teaching Priorities

- Explain generics as compile-time type parameters that preserve type safety without duplicating code.
- Show the concrete version first when the learner is new, then generalize it.
- Explain constraints as promises the generic code can rely on.
- Distinguish generic type parameters from runtime values.
- Use official C# docs for version-sensitive features such as generic math, static abstract interface members, and newer constraint forms.

## Review Priorities

1. Check whether the generic abstraction removes real duplication or clarifies a reusable contract.
2. Prefer meaningful type parameter names for public APIs when one-letter names become unclear.
3. Add constraints only when the implementation needs them.
4. Avoid generic repositories or generic service layers when they hide domain behavior or weaken query boundaries.
5. Watch for boxing, reflection-heavy generic code, and unnecessary runtime type checks.
6. For variance, explain `out` as producer positions and `in` as consumer positions; verify with official docs if the rule matters.

## Common Feedback

- Use generic methods for small reusable algorithms.
- Use generic interfaces to describe reusable contracts.
- Prefer concrete types when only one type is ever valid.
- Avoid exposing overly flexible generic APIs that make invalid states easy.
- Test representative type arguments, including nullable/reference/value types when behavior differs.
