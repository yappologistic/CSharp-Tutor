# C# Review Checklist

Use this checklist when reviewing a C# snippet, file, or codebase. Prioritize material issues over exhaustive nits.

## Correctness

- Does the code compile with the stated target framework and language version?
- Are nullable reference type warnings handled deliberately?
- Can input be null, empty, malformed, too large, duplicated, missing, or out of range?
- Are exceptions handled at the correct layer without swallowing useful failure information?
- Are culture, timezone, encoding, comparison, and casing choices explicit where user data is involved?
- Are resources disposed with `using`, `await using`, or ownership transfer?
- Are async methods awaited correctly, and are blocking calls avoided in async paths?

## Security

- Is untrusted input validated, normalized, encoded, parameterized, or rejected as appropriate?
- Are database queries parameterized and protected from injection?
- Are file paths constrained to intended directories and checked for traversal?
- Are authentication and authorization checks enforced server-side at the right boundary?
- Are secrets kept out of code, logs, exceptions, telemetry, URLs, and client responses?
- Are cryptographic APIs current, correctly configured, and used for the right purpose?
- Are serialization, deserialization, model binding, and over-posting risks controlled?
- Are dependencies reviewed for vulnerable, deprecated, or unmaintained packages?

## Maintainability

- Does each type or method have a clear responsibility?
- Are names specific enough to reveal domain intent?
- Are methods short enough to follow without hiding important branching?
- Is duplication meaningful enough to extract?
- Are dependencies injected at boundaries instead of created deep inside business logic?
- Are interfaces used where substitution is useful, not merely by habit?
- Is shared mutable state minimized or protected?

## Object-Oriented Design

- Is behavior placed with the data and responsibility it belongs to?
- Are invariants protected through constructors, factories, validation, or encapsulation?
- Is inheritance used only for true substitutability?
- Would composition, strategy, policy, or small services reduce coupling?
- Are domain models distinct from transport, persistence, or UI models when the app is large enough to benefit?

## Performance and Scalability

- Is work repeated unnecessarily inside loops, requests, or hot paths?
- Are collections, dictionaries, sets, spans, streams, or pipelines chosen appropriately?
- Are LINQ queries enumerated multiple times or causing hidden allocations?
- Are I/O operations asynchronous where scale matters?
- Are cancellation tokens passed through request, I/O, and background work boundaries?
- Are large strings, byte arrays, or object graphs copied unnecessarily?
- Are caches bounded, invalidated, and safe under concurrency?

## Testing

- Are core behaviors covered by unit or integration tests?
- Are edge cases, error paths, cancellation, and authorization failures tested?
- Can time, randomness, file system, network, database, and external services be replaced in tests?
- Are refactors protected by characterization tests when behavior is unclear?

## Feedback Shape

Report findings in this order:

1. Correctness and safety
2. Security and future bug risks
3. Maintainability and design
4. Performance and scalability
5. Modern C#/.NET opportunities
6. Optional tips

For each important issue, include the issue, why it matters, a concrete improvement, and source-backed rationale when relevant.
