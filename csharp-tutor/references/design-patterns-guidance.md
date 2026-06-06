# Design Patterns Guidance

Use this reference for C# design pattern questions and refactors.

## Pattern Selection Rule

Start with the concrete design pressure:

- Repeated conditional behavior: consider Strategy or polymorphism.
- Object creation complexity: consider Factory or Builder.
- Add behavior without changing the wrapped type: consider Decorator.
- Translate between incompatible interfaces: consider Adapter.
- Coordinate request handling or workflows: consider Mediator or Command.
- Publish changes to subscribers: consider Observer or events.
- Data access abstraction: consider Repository only when it protects domain boundaries or testability; avoid generic repositories over EF Core by default.
- Transaction coordination: consider Unit of Work when there are multiple operations that must commit together; remember EF Core DbContext already acts like a unit of work in many apps.

## Anti-Overengineering Checks

- Is there more than one real implementation or variation point?
- Will the abstraction make invalid use harder, or just add files?
- Does the pattern reduce coupling or hide important behavior?
- Can a simpler method, class, delegate, or switch expression solve it?
- Will a beginner maintain this code more easily after the pattern?

## Review Priorities

1. Preserve behavior before changing structure.
2. Name the smell or pressure before naming the pattern.
3. Show a minimal before/after.
4. Explain the tradeoff and when not to use the pattern.
5. Add tests around behavior before large pattern refactors.

## Teaching Style

For learners, describe the pattern in plain language, show a small example, then connect it back to their code. Avoid pattern catalogs unless the user asks for a catalog.
