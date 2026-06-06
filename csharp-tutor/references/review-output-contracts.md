# Review Output Contracts

Use this reference when the user asks for predictable review output or provides a `profile`.

## Review Scope

Honor `scope=...` hints:

- `scope=correctness`: compile errors, runtime exceptions, nullability, resource lifetime, async misuse, data loss, logic bugs.
- `scope=security`: untrusted input, auth/authz, injection, secrets, logging, serialization, crypto, files, dependency risk.
- `scope=performance`: allocations, hot paths, data structures, async scalability, database queries, serialization, memory pressure, measurement.
- `scope=architecture`: responsibilities, coupling, dependency direction, DTO/entity boundaries, modularity, testability, maintainability.
- `scope=tests`: missing tests, weak assertions, nondeterminism, testability blockers, regression coverage.
- `scope=all`: full review ordered by risk.

If a requested scope would hide a severe correctness or security issue, include that issue briefly under a "must mention" note.

## Snippet Review

Return:

1. Main finding list ordered by severity.
2. Corrected snippet or minimal patch when useful.
3. Explanation of why the fix works.
4. Optional tips.
5. One verification step.

## File Review

Return:

1. Findings with file and line references when available.
2. Issue clusters if several findings share a cause.
3. Focused refactor direction.
4. Tests or tooling checks.

## Project Review

Return:

1. Project context: target framework, app type, packages, and assumptions.
2. High-risk areas first.
3. Architecture and maintainability clusters.
4. Performance and modernization notes.
5. Prioritized next steps.

## Refactor Review

Return:

1. Behavior to preserve.
2. Smell or design pressure.
3. Small refactor sequence.
4. Before/after code for the key change.
5. Tests that should protect the refactor.

## Interview Answer Review

Return:

1. Score or verdict.
2. What was correct.
3. What was missing or wrong.
4. Stronger answer.
5. Follow-up question.
