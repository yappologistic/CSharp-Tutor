# Exercise Guidance

Use exercises when the user is learning a concept, asks for practice, or would benefit from applying feedback to their own code.

## Drill Hints

Honor `drill=...`:

- `drill=string-parsing`: parsing, validation, culture, edge cases.
- `drill=collections`: list/dictionary/set choice, mutation, equality.
- `drill=linq`: filtering, projection, grouping, joins, deferred execution.
- `drill=oop-modeling`: classes, interfaces, encapsulation, responsibilities.
- `drill=unit-tests`: arrange/act/assert, edge cases, regression tests.
- `drill=async`: async I/O, cancellation, exception flow.
- `drill=refactoring`: preserve behavior while improving structure.

For drills, keep the scope small, provide expected behavior, and avoid giving the full solution unless `reveal=true`.

## Exercise Shape

Keep exercises small and runnable:

1. State the task.
2. Provide starter code only when useful.
3. Specify expected behavior or output.
4. Add one hint.
5. Offer a solution only when the user asks or after they attempt it.

## Exercise Types

### Concept Practice

Use for syntax and language rules.

```text
Task: Rewrite this `if`/`else` chain as a switch expression.
Expected behavior: Same output for all listed inputs.
Hint: Start by matching the exact values, then add the fallback arm.
```

### Code Quality Practice

Use for maintainability and clean code.

```text
Task: Split this method into smaller methods with clear names.
Expected behavior: Existing tests still pass.
Hint: Extract one responsibility at a time.
```

### OOP Practice

Use for encapsulation, interfaces, inheritance, and composition.

```text
Task: Replace this inheritance-based design with composition.
Expected behavior: Each behavior can vary independently.
Hint: Look for the part that changes between subclasses.
```

### Async Practice

Use for `async`/`await`, cancellation, and I/O.

```text
Task: Convert this synchronous file read to an async method with cancellation.
Expected behavior: The caller can cancel before or during the operation.
Hint: Pass the `CancellationToken` through every async API that accepts it.
```

### Security Practice

Use for input validation, paths, SQL, auth, secrets, logging, and serialization.

```text
Task: Make this file-loading method reject path traversal.
Expected behavior: Inputs outside the allowed directory fail safely.
Hint: Normalize the path before checking whether it stays under the allowed root.
```

### Modernization Practice

Use for newer C#/.NET features.

```text
Task: Convert this immutable DTO class to a record if the target version supports it.
Expected behavior: The public data shape stays the same, and equality becomes value-based.
Hint: Check whether any serializer or ORM depends on a parameterless constructor.
```
