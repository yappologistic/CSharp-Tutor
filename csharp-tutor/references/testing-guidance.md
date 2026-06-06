# Testing Guidance

Use this reference when suggesting tests, reviewing testability, or helping the user learn how to verify C# behavior.

## Test Types

- Unit tests: fast checks of domain logic, small services, pure functions, validation, and edge cases.
- Integration tests: verify database, HTTP, file system, dependency injection, configuration, serialization, or framework behavior.
- End-to-end tests: verify full workflows through deployed or near-deployed paths.
- Characterization tests: capture current behavior before risky refactors.

## Frameworks

- xUnit, NUnit, and MSTest are all acceptable. Prefer the project's existing framework.
- Use FluentAssertions or similar assertion libraries only if already present or the user wants improved readability.
- Avoid adding mocking frameworks unless boundaries are hard to instantiate and the project already accepts that style.

## What to Test

Prioritize:

- Correct behavior for normal, boundary, and invalid inputs.
- Nullability and validation contracts.
- Error handling and exception translation.
- Authorization and ownership checks.
- Serialization/deserialization behavior.
- Async cancellation and failure paths.
- Time-dependent logic with `TimeProvider` or an injected clock.
- File, network, and database behavior through integration tests when framework behavior matters.

## Async Tests

- Test methods should return `Task`, not `async void`.
- Await the operation under test.
- Test cancellation by passing a `CancellationTokenSource` and asserting expected behavior.
- Avoid sleeps when possible; use controllable time or synchronization primitives.

## Testability Refactors

Suggest:

- Injecting time, randomness, file system, HTTP, database, and external service boundaries.
- Keeping domain logic separate from I/O where practical.
- Replacing static hidden dependencies with explicit collaborators.
- Adding small tests before large behavior-preserving refactors.

## Feedback Style

When recommending tests, include:

- The behavior to prove.
- The level of test needed.
- One representative test name or skeleton.
- Why that test would catch the issue being discussed.
