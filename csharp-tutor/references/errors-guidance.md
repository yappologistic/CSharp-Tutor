# C# Error Handling Guidance

Use this reference for exceptions, guard clauses, validation, result patterns, and debugging common failures. Use `compiler-error-library.md` for specific compiler diagnostics, runtime exception triage, and stack-trace response patterns.

## Exceptions

- Use exceptions for exceptional failure, not normal control flow.
- Catch exceptions only when you can add handling, translation, cleanup, retry, or useful context.
- Preserve stack traces with `throw;`, not `throw ex;`.
- Avoid swallowing exceptions silently.
- Do not leak sensitive details in user-facing errors.

## Guard Clauses and Validation

- Use guard clauses for invalid method arguments.
- Validate external input at boundaries.
- Keep domain invariants protected in constructors, factories, or methods.
- Prefer clear error messages that identify the invalid input without exposing secrets.

## Result Patterns

Use result-style return values when failure is expected and part of normal business flow, such as validation errors or user-correctable input.

Use exceptions when the operation cannot complete because of an unexpected or infrastructure-level failure.

## Common Beginner Issues

- Confusing compiler errors with runtime exceptions.
- Catching all exceptions and printing only "error".
- Returning `null` for errors without documenting it.
- Using `int.Parse` on user input instead of `TryParse`.
- Letting invalid objects exist and hoping later code catches the problem.

## Debugging Shape

For error questions, provide:

1. What the error means.
2. Where it likely comes from.
3. How to confirm it.
4. The smallest safe fix.
5. How to prevent the same class of bug.
