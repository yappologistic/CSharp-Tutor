# Debug Lab Guidance

Use this reference for diagnosis-first C# debugging exercises.

## Lab Flow

1. Choose one bug category and learner level.
2. Show a small broken snippet or scenario.
3. State the symptom, compiler error, exception, failing test, or wrong output.
4. Ask the learner to diagnose before revealing the answer.
5. Give hints one at a time if requested.
6. After the learner attempts, explain root cause, fix, and prevention rule.
7. Add one follow-up variation.

## Difficulty And Hint Controls

- `difficulty=easy`: a single obvious bug, short snippet, one symptom.
- `difficulty=medium`: a realistic bug involving two concepts or a misleading symptom.
- `difficulty=hard`: multi-step diagnosis, framework behavior, concurrency, async, EF Core, or testing traps.
- `hint=1`, `hint=2`, `hint=3`: reveal progressively stronger hints.
- `reveal=false`: default; do not reveal the solution before the learner attempts.
- `reveal=true`: include the full solution immediately after the prompt.
- `next_difficulty=true`: after a correct attempt, increase difficulty by one level; after a weak attempt, give a similar-level variation.

## Bug Categories

- Compiler errors: type mismatch, missing using, accessibility, generics constraints, nullable warnings.
- Runtime exceptions: null reference, invalid operation, format errors, index errors, disposal.
- Logic bugs: off-by-one, equality, mutation, time/culture parsing, integer division.
- LINQ bugs: deferred execution, repeated enumeration, wrong predicate, grouping/key mistakes.
- Async bugs: missing await, `.Result`, swallowed exceptions, cancellation not passed.
- Concurrency bugs: race condition, shared mutable state, lock misuse.
- EF Core bugs: query translation, tracking, N plus one, client evaluation assumptions.
- Tests: weak assertions, nondeterministic tests, hidden dependencies.

## Output Contract

For a lab, return:

1. Title and difficulty.
2. Broken code or scenario.
3. Symptom.
4. Prompt: "What do you think is wrong?"
5. Available commands: `hint=1`, `hint=2`, `hint=3`, `reveal=true`, `next_difficulty=true`.
6. Hidden solution note: do not reveal unless asked or after learner attempts.

When revealing:

1. Root cause.
2. Corrected code.
3. Why the fix works.
4. Prevention rule.
5. Practice variation.
