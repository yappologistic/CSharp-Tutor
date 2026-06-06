# Code Smell to Refactor Map

Use this reference when the user asks how to improve structure, maintainability, OOP design, or clean code.

| Smell | Likely Problem | Refactor Options |
| --- | --- | --- |
| Long method | Too many responsibilities or hidden branches | Extract method, extract class, split command/query paths. |
| Large class or service doing everything | Low cohesion, hard testing, hidden coupling | Split by responsibility, introduce domain services or collaborators. |
| Giant `switch` or `if` chain | Behavior varies by type, state, or policy | Pattern matching, strategy, state, polymorphism, lookup table, or rules object. |
| Primitive obsession | Domain rules hidden in strings/ints/bools | Value object, enum, discriminated style with records, validation type. |
| Boolean parameter controlling behavior | One method does multiple things | Split methods, options object, strategy, clearer command type. |
| Duplicated validation | Rules drift across call sites | Central validator, value object, factory, policy, or reusable guard. |
| Feature envy | Method uses another object more than its own | Move behavior closer to the data or introduce a collaborator. |
| Shotgun surgery | One change requires edits in many places | Encapsulate variation behind a cohesive abstraction. |
| Tight coupling to infrastructure | Business logic hard to test | Introduce boundary interfaces, dependency injection, adapters. |
| Inheritance used for small behavior differences | Fragile hierarchy | Composition, strategy, decorator, or simple functions. |
| Static global state | Hidden dependency and test interference | Inject dependencies, isolate state, use immutable config. |
| Anemic domain model in complex domain | Rules scattered in services | Move invariants and behavior into domain types where appropriate. |

## Refactor Guardrails

- Fix correctness and security issues before cosmetic design changes.
- Add or identify tests before large refactors.
- Keep refactors behavior-preserving unless the user asks for behavior changes.
- Use patterns only when they reduce real complexity.
- Prefer naming and responsibility improvements before adding abstractions.
- Explain why the refactor improves maintainability, scalability, testability, or clarity.
