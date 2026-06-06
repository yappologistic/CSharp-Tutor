# Code Smell Catalog

Use this reference when the user asks how to improve structure, maintainability, OOP design, clean code, testability, or scalability.

Treat smells as design clues, not automatic defects. First identify the concrete pain: bugs, hard testing, duplicated changes, unclear intent, framework coupling, or slow delivery. Then recommend the smallest behavior-preserving refactor that relieves that pain.

## How to Use This Catalog

For each meaningful smell:

1. Name the smell in plain language.
2. Point to the symptom in the user's code.
3. Explain why it matters for correctness, maintainability, testability, or change cost.
4. Offer a beginner-safe fix first.
5. Offer a production-grade option only when the added structure is justified.
6. Say when not to fix it.
7. Suggest a test or characterization check when behavior could be disturbed.

Do not turn every smell into a pattern. Prefer better names, smaller methods, clearer ownership, and tests before adding abstractions.

## Quick Map

| Smell | Symptom | Beginner-Safe Fix | Production-Grade Option |
| --- | --- | --- | --- |
| Long method | Mixed validation, calculation, I/O, mapping, and branching | Extract named helper methods around obvious steps | Split orchestration from policies, workflows, or domain behavior |
| Large class or service | One type handles many unrelated use cases | Group methods by responsibility and move one group out | Split by application service, domain service, adapter, or feature slice |
| Giant conditional | Large `if`, `switch`, or repeated type/status checks | Use guard clauses, switch expressions, or lookup tables | Strategy, state, polymorphism, rules object, or mediator-style dispatch |
| Primitive obsession | Domain concepts represented as loose strings, ints, bools | Rename variables and add validation helpers | Value objects, enums, records, or strongly typed identifiers |
| Boolean parameter | `save(order, true)` changes behavior invisibly | Split into two clearly named methods | Options object, command type, or separate workflow |
| Duplicated validation | Same rule copied in UI, service, and model | Extract one helper or validator method | Value object, validation service, policy, or domain invariant |
| Feature envy | Method mostly manipulates another object's data | Move the method closer to the data | Introduce a collaborator that owns the behavior |
| Shotgun surgery | One change requires many small edits | Centralize the repeated rule or mapping | Encapsulate variation behind a stable boundary |
| Tight infrastructure coupling | Business rules call files, DB, HTTP, clock, or console directly | Pass dependencies as parameters where simple | Ports/adapters, dependency injection, repositories, gateways |
| Fragile inheritance | Subclasses override small behavior differences | Prefer composition or injected behavior | Strategy, decorator, template method only when hierarchy is stable |
| Static global state | Tests affect each other or hidden dependencies appear | Pass values explicitly, reset state in tests | Inject services, immutable configuration, scoped state |
| Anemic domain model | Complex domain rules live in procedural services | Move one invariant into the domain type | Rich domain model with aggregate boundaries where complexity warrants it |
| Data clump | Same values travel together repeatedly | Introduce a small parameter object or record | Value object with validation and behavior |
| Message chain | Code reaches through several objects repeatedly | Store intermediate value with a clear name | Move behavior behind a method on the owning object |
| Middle man | Class only forwards calls with no policy | Inline the class if it adds no boundary | Keep it only if it protects a real seam such as auth, caching, or external I/O |
| Hidden side effects | Method name says query but mutates state, logs, or saves | Rename method and separate command from query | Explicit command handler or workflow boundary |
| Inconsistent error handling | Mix of nulls, exceptions, booleans, and result objects | Pick one local convention and document it | Domain-specific result types, exception translation, or validation pipeline |
| Overly broad abstraction | Interface has one implementation and no boundary need | Use the concrete type directly | Keep abstraction for external systems, public APIs, tests, or plugin points |
| God options object | Many optional properties with invalid combinations | Split options by scenario | Command records or builder with validation |
| Repeated mapping code | DTO/entity/model conversions copied across handlers | Extract mapping method | Dedicated mapper or projection layer when mapping is complex |

## Smell Details

### Long Method

**Why it hurts:** A long method hides the order of operations and makes small changes risky because validation, business logic, persistence, and formatting are tangled.

**Beginner-safe fix:** Extract a few named private methods that describe intent, such as `ValidateOrder`, `CalculateTotal`, or `BuildReceipt`.

**Production-grade option:** Split orchestration from policy decisions. Keep the public method as a readable workflow and move reusable rules into collaborators or domain methods.

**Do not fix when:** The method is short, linear, and clearer as one sequence, such as simple parsing or a small script.

**Protect with:** Tests for each visible outcome before splitting heavily branched logic.

### Large Class or Service

**Why it hurts:** A class that owns too many workflows becomes hard to test, hard to name, and easy to break with unrelated edits.

**Beginner-safe fix:** List the responsibilities in comments or notes, then move one cohesive group of methods into a new type.

**Production-grade option:** Split by feature, application service, domain responsibility, adapter, or vertical slice. Keep dependencies pointing inward toward business rules.

**Do not fix when:** The class is a small facade with a clear purpose and no duplicated change pressure.

**Protect with:** Characterization tests around the public methods being moved.

### Giant Conditional

**Why it hurts:** Repeated `if` or `switch` logic often means behavior varies by policy, state, type, role, or command. New cases become easy to forget.

**Beginner-safe fix:** Use guard clauses, a switch expression, or a dictionary lookup when the mapping is simple.

**Production-grade option:** Use strategy, state, polymorphism, rules objects, or command handlers when each branch has meaningful behavior and changes independently.

**Do not fix when:** There are only two or three stable cases and the switch is the clearest representation.

**Protect with:** One test per branch, especially for default or unknown cases.

### Primitive Obsession

**Why it hurts:** Strings, ints, decimals, and booleans can carry business meaning without enforcing valid ranges, formats, units, or combinations.

**Beginner-safe fix:** Rename variables clearly and create validation helpers such as `IsValidEmail` or `IsPositiveAmount`.

**Production-grade option:** Create a value object, enum, record, or strongly typed ID that validates once and prevents invalid states from spreading.

**Do not fix when:** The value is purely local, obvious, and has no reusable rule.

**Protect with:** Tests for invalid values, boundary values, parsing, and serialization if the type crosses API boundaries.

### Boolean Parameter

**Why it hurts:** A boolean argument often hides two behaviors behind one method, and call sites like `Process(user, true)` do not explain intent.

**Beginner-safe fix:** Split into named methods, such as `SaveDraft` and `Publish`, or rename the parameter and use named arguments.

**Production-grade option:** Use an options object, command record, or strategy when the behavior has multiple dimensions.

**Do not fix when:** The boolean is obvious and conventional, such as `StringComparison ignoreCase` alternatives are not applicable, or a small local helper is clear.

**Protect with:** Tests proving both behavior paths still work after the split.

### Duplicated Validation

**Why it hurts:** Copied rules drift. One call site accepts data that another rejects, which creates bugs and inconsistent user experience.

**Beginner-safe fix:** Extract one helper method and call it from each location.

**Production-grade option:** Put invariants in value objects or domain types. Use validators or policies at boundaries where data enters the system.

**Do not fix when:** Two checks look similar but enforce different business rules in different contexts.

**Protect with:** Shared tests for accepted and rejected inputs.

### Feature Envy

**Why it hurts:** A method that mostly reads or mutates another object's fields is usually located on the wrong type.

**Beginner-safe fix:** Move the method to the type that owns the data, or pass only the specific values needed.

**Production-grade option:** Introduce a collaborator when behavior spans multiple objects and no single domain type owns it.

**Do not fix when:** The method is mapping, formatting, or coordinating across boundaries by design.

**Protect with:** Tests around the moved behavior and any nullability assumptions.

### Shotgun Surgery

**Why it hurts:** If one requirement change forces many edits, the rule or variation is not encapsulated.

**Beginner-safe fix:** Find the repeated phrase, condition, or mapping and centralize it.

**Production-grade option:** Introduce a stable abstraction around the variation point, such as a pricing policy, authorization policy, mapper, or provider.

**Do not fix when:** The edits are one-time migration work or separate requirements that only look similar.

**Protect with:** Tests that describe the shared rule once and cover representative call sites.

### Tight Infrastructure Coupling

**Why it hurts:** Business logic that directly uses files, HTTP, databases, clocks, random numbers, console I/O, or environment variables is harder to test and reuse.

**Beginner-safe fix:** Pass needed values into the method instead of reading them globally.

**Production-grade option:** Introduce interfaces or adapters at real boundaries and inject them. Keep domain logic independent of infrastructure details.

**Do not fix when:** The code is a tiny one-off script or the boundary abstraction would be larger than the behavior being protected.

**Protect with:** Unit tests using fake time, fake I/O, or in-memory collaborators.

### Fragile Inheritance

**Why it hurts:** Inheritance couples subclasses to base-class implementation details. Small base changes can break derived behavior.

**Beginner-safe fix:** Replace small behavior differences with a contained helper object or function.

**Production-grade option:** Use composition, strategy, decorator, or template method only when the variation is stable and the hierarchy is intentional.

**Do not fix when:** The inheritance models a stable framework contract or true substitutability.

**Protect with:** Tests that run through the base type and each subtype.

### Static Global State

**Why it hurts:** Static mutable state creates hidden dependencies, order-sensitive tests, and concurrency risks.

**Beginner-safe fix:** Pass state explicitly and reset unavoidable static state in tests.

**Production-grade option:** Use dependency injection, immutable configuration, scoped services, or message passing.

**Do not fix when:** The static member is a constant, pure helper, cached immutable data, or framework-required entry point.

**Protect with:** Tests that run independently and in different orders.

### Anemic Domain Model

**Why it hurts:** In complex domains, putting all rules in services can scatter invariants and allow invalid objects to exist too long.

**Beginner-safe fix:** Move one obvious invariant into the domain type, such as preventing a negative balance.

**Production-grade option:** Model aggregates, value objects, and domain services around real business rules.

**Do not fix when:** The app is CRUD-heavy, rules are simple, or a rich model would obscure straightforward data flow.

**Protect with:** Domain-level tests for invariants and state transitions.

### Data Clump

**Why it hurts:** Repeated groups of parameters suggest a missing concept and make call sites noisy.

**Beginner-safe fix:** Introduce a small record or parameter object with a clear name.

**Production-grade option:** Make it a validated value object if the grouped values have business rules.

**Do not fix when:** The values are only used together once or a new type would hide simple code.

**Protect with:** Tests for construction and validation if the new type enforces rules.

### Message Chain

**Why it hurts:** Reaching through many objects, such as `order.Customer.Address.Country.Code`, exposes internal structure and spreads navigation logic.

**Beginner-safe fix:** Store intermediate values with clear names and null checks.

**Production-grade option:** Add a method or property on the owning object that answers the needed question.

**Do not fix when:** The chain is simple DTO projection or serialization where shape is the purpose.

**Protect with:** Tests for missing or optional nested values.

### Middle Man

**Why it hurts:** A class that only forwards calls adds noise and indirection without reducing coupling.

**Beginner-safe fix:** Inline the wrapper or call the dependency directly.

**Production-grade option:** Keep or introduce the wrapper only when it enforces policy, logging, caching, retry, authorization, or external boundary isolation.

**Do not fix when:** The class is a facade that deliberately simplifies a complex subsystem.

**Protect with:** Tests around any policy that justifies the wrapper.

### Hidden Side Effects

**Why it hurts:** Methods that look like queries but mutate state, save data, publish messages, or call external systems surprise callers.

**Beginner-safe fix:** Rename the method to reveal the side effect and split read logic from write logic.

**Production-grade option:** Use explicit command/query separation around application workflows.

**Do not fix when:** The side effect is the method's clear purpose and the name says so.

**Protect with:** Tests that assert both returned values and state changes.

### Inconsistent Error Handling

**Why it hurts:** Mixing nulls, booleans, exceptions, result objects, and magic strings makes failures hard to reason about.

**Beginner-safe fix:** Pick one convention for the local operation and document it through names such as `TryCreate`, `Validate`, or `GetRequired`.

**Production-grade option:** Use domain-specific result types, exception translation at boundaries, and validation flows that preserve useful error details.

**Do not fix when:** Different layers intentionally use different conventions, such as exceptions internally and problem details at an HTTP boundary.

**Protect with:** Tests for failure cases, not only happy paths.

### Overly Broad Abstraction

**Why it hurts:** Interfaces and base classes without a real boundary make code harder to navigate and change.

**Beginner-safe fix:** Remove the interface until there is more than one implementation or a concrete external boundary.

**Production-grade option:** Keep abstractions around public APIs, external services, plugins, persistence, clocks, or tests that need substitution.

**Do not fix when:** The abstraction is part of a stable architecture boundary or public contract.

**Protect with:** Tests through the public behavior, not through the abstraction itself.

### God Options Object

**Why it hurts:** A large options object with many optional properties can represent invalid combinations.

**Beginner-safe fix:** Split the method into scenario-specific methods or use required constructor parameters.

**Production-grade option:** Use command records, discriminated-style records, builders with validation, or separate options types per workflow.

**Do not fix when:** The options object maps directly to stable external configuration and validation is handled clearly.

**Protect with:** Tests for invalid combinations and defaults.

### Repeated Mapping Code

**Why it hurts:** Copied DTO/entity/view-model mapping drifts and can create missing fields, over-posting risks, or inconsistent formatting.

**Beginner-safe fix:** Extract a named mapping method near the use case.

**Production-grade option:** Use projections, dedicated mappers, or mapping profiles when mappings are numerous and tested.

**Do not fix when:** The mapping is a one-off projection and extracting it would hide query translation or data shape.

**Protect with:** Tests for important fields and, for EF Core, checks that projections translate as intended.

## Refactor Guardrails

- Fix correctness and security issues before cosmetic design changes.
- Add or identify tests before large refactors.
- Keep refactors behavior-preserving unless the user asks for behavior changes.
- Use patterns only when they reduce real complexity.
- Prefer naming and responsibility improvements before adding abstractions.
- Respect the learner's level: give one clear refactor path before advanced alternatives.
- Explain why the refactor improves maintainability, scalability, testability, or clarity.
- Mention what not to change when the current code is simple enough.
