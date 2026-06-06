# C# OOP Guidance

Use this reference when teaching or reviewing object-oriented C# design.

## Core Ideas

- A class should model a meaningful responsibility, not just a bag of data and unrelated methods.
- Encapsulation means protecting invariants and exposing behavior through a clear public API.
- Interfaces describe capabilities or boundaries, especially when substitution, testing, or dependency inversion matters.
- Inheritance is strongest for true "is-a" relationships and substitutable behavior.
- Composition is often better when behavior varies independently.

## Design Questions

Ask:

- What responsibility does this class own?
- What data must stay valid?
- Which methods protect or change that data?
- What should be private because outside code should not control it directly?
- What dependency should be injected because it is infrastructure or replaceable behavior?
- Is this abstraction helping, or just adding ceremony?

## SOLID in Practical Terms

- Single Responsibility: one reason to change.
- Open/Closed: add new behavior without editing many existing branches when variation is real.
- Liskov Substitution: derived types must be usable where the base type is expected.
- Interface Segregation: avoid forcing callers to depend on methods they do not use.
- Dependency Inversion: high-level policy should not depend directly on low-level infrastructure.

## Beginner-Friendly Guidance

- Start with concrete classes first, then extract interfaces only when a boundary becomes clear.
- Keep UI/console input separate from domain logic.
- Keep persistence separate from business rules.
- Avoid design patterns until there is a repeated variation or dependency problem.

## Common Refactors

- Move transaction rules into a domain service or `BankAccount` method, not the console menu.
- Expose transaction history as read-only while keeping the backing collection private.
- Use separate DTOs for persistence or JSON when the stored shape differs from the domain object.
- Split console navigation, account behavior, storage, and formatting into separate responsibilities.
