# Architecture Guidance

Use this reference for C# application architecture, maintainability, scalability, dependency direction, clean architecture, layered architecture, vertical slices, modularity, and design pattern fit.

## First Checks

- Identify application type, team context, expected growth, deployment constraints, and current pain: duplication, coupling, slow changes, fragile tests, unclear ownership, or performance.
- Inspect project structure, dependency direction, service boundaries, data access boundaries, DTO mapping, validation, error handling, and tests.
- Avoid prescribing an architecture style before understanding the actual complexity.

## Review Priorities

1. Correct behavior and clear use cases before architectural reshaping.
2. Dependency direction: domain/application behavior should not depend unnecessarily on UI, database, or framework details.
3. Boundaries around external systems such as database, file system, HTTP APIs, time, queues, and identity.
4. Cohesion: group code by behavior or feature when it reduces navigation and coupling.
5. Testability: isolate business rules from infrastructure enough to test them.
6. DTO and entity boundaries: do not expose persistence entities directly across public API boundaries by default.
7. Incremental migration path: recommend small refactors that preserve behavior.

## Pattern Guidance

- Layered architecture helps when a small app needs familiar separation between presentation, application logic, and data access.
- Vertical slice architecture helps when features are independent and cross-layer navigation is slowing changes.
- Clean architecture helps when business rules must be isolated from frameworks and infrastructure.
- Domain services help when behavior does not naturally belong to a single entity.
- Application services help orchestrate workflows, transactions, authorization checks, and external dependencies.
- Design patterns should remove concrete complexity; do not introduce them just to name a pattern.

## Common Feedback

- Start by extracting behavior from oversized controllers, UI handlers, or data-access classes.
- Prefer explicit dependencies and simple constructors.
- Keep validation, mapping, persistence, and business rules from collapsing into one class.
- Add tests around behavior before large architecture refactors.
- Keep beginner projects simple; explain what would change at production scale.
