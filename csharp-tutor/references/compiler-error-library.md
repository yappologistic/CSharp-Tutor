# Compiler and Runtime Error Library

Use this reference when the user shares C# compiler diagnostics, runtime exceptions, stack traces, failing tests, or vague "it does not work" symptoms.

This library is a triage aid, not a substitute for reading the user's code. Error codes can have several causes. Give the likely cause, show how to confirm it, and recommend the smallest fix first.

## Debugging Response Pattern

For error help, respond with:

1. What the error means in plain language.
2. The most likely cause in the user's code.
3. How to confirm it.
4. The smallest fix.
5. Why the fix works.
6. A prevention tip or test when useful.

When the user gives a stack trace, identify the first frame in their code and focus there before discussing framework internals.

## Common Compiler Diagnostics

### `CS0103`: The name does not exist in the current context

**Meaning:** The compiler cannot find a variable, method, property, type, or field with that name where it is being used.

**Likely causes:**

- Misspelled name or wrong capitalization.
- Variable declared inside a narrower scope such as an `if`, loop, or method.
- Missing field/property on the current class.
- Code is in the wrong class or namespace.

**Smallest fix:** Move the declaration into the needed scope, fix the name, or qualify the member through the correct object.

**Prevention tip:** Keep variable lifetimes small, but declare values outside a block when later code genuinely needs them.

### `CS0246`: The type or namespace name could not be found

**Meaning:** The compiler cannot resolve a type or namespace.

**Likely causes:**

- Missing `using` directive.
- Missing project or package reference.
- Wrong namespace.
- Type name is misspelled.
- The package targets a different framework than the project.

**Smallest fix:** Add the correct `using`, reference the project/package, or use the fully qualified type name to confirm the namespace.

**Prevention tip:** For project-wide issues, inspect the `.csproj` before suggesting packages or framework-specific APIs.

### `CS1061`: Type does not contain a definition for member

**Meaning:** The expression's compile-time type does not have the method, property, or extension method being called.

**Likely causes:**

- Calling a member on the wrong type.
- Missing extension-method namespace.
- The variable is typed as an interface/base class that does not expose the member.
- API exists in a different .NET version.

**Smallest fix:** Check the variable's type, add the needed `using` for extension methods, or call the member on the correct object.

**Prevention tip:** In explanations, distinguish runtime type from compile-time type.

### `CS1503`: Argument cannot convert from one type to another

**Meaning:** A method call has an argument whose type does not match the parameter.

**Likely causes:**

- Passing a string where an int, decimal, enum, or object is expected.
- Nullable value passed to non-nullable parameter.
- Wrong generic type, such as `List<Dog>` where `List<Animal>` is expected.
- Culture-sensitive parsing assumed to happen automatically.

**Smallest fix:** Convert or parse explicitly, change the method signature if the caller is right, or pass the correct property.

**Prevention tip:** Avoid broad conversions until the desired type and failure behavior are clear.

### `CS7036`: No argument given for required parameter

**Meaning:** A constructor or method requires a parameter that was not supplied.

**Likely causes:**

- Constructor changed but call sites were not updated.
- Dependency injection registration cannot construct a service.
- Optional parameter was expected but no default exists.

**Smallest fix:** Provide the missing argument, add a sensible default only if it is truly optional, or update DI registration.

**Prevention tip:** For constructors, keep required dependencies explicit and avoid adding defaults that hide invalid object state.

### `CS0029`: Cannot implicitly convert type

**Meaning:** The compiler will not automatically convert the right-hand expression to the left-hand type.

**Likely causes:**

- Assigning a collection element to a collection variable or the reverse.
- Assigning `Task<T>` to `T` because `await` is missing.
- Assigning nullable to non-nullable without checking.
- Confusing DTO/entity/model types.

**Smallest fix:** Use the correct target type, await the task, map explicitly, or handle null before assignment.

**Prevention tip:** Read both sides of the assignment aloud: "I am assigning X to Y."

### `CS0165`: Use of unassigned local variable

**Meaning:** The compiler cannot prove a local variable has been assigned before it is read.

**Likely causes:**

- Assignment happens only inside a conditional branch.
- Try/catch path skips assignment.
- Out parameter or parsing result is read without checking success.

**Smallest fix:** Initialize the variable, return early on failure, or ensure every branch assigns it.

**Prevention tip:** Guard clauses often make definite assignment easier to see.

### `CS8600` to `CS8625`: Nullable reference warning family

**Meaning:** Nullable analysis found a possible null assignment, dereference, return, or argument mismatch.

**Likely causes:**

- External input not checked.
- `FirstOrDefault`, dictionary lookup, deserialization, or configuration can return null.
- Non-nullable property is not initialized.
- `!` is hiding a real uncertainty.

**Smallest fix:** Check for null, use `TryGetValue`, initialize required members, or adjust the contract to nullable when null is valid.

**Prevention tip:** Treat nullable warnings as contract feedback. Avoid suppressing with `!` unless a framework guarantee exists and is documented.

### `CS1998`: Async method lacks await

**Meaning:** A method is marked `async` but has no `await`.

**Likely causes:**

- Method was made async preemptively.
- Missing await on an async call.
- Returning completed values from an interface-required async method.

**Smallest fix:** Remove `async` and return directly, add the missing `await`, or return `Task.FromResult`/`ValueTask.FromResult` when appropriate.

**Prevention tip:** Do not use `async` unless the method awaits or must match an async contract.

## Common Runtime Exceptions

### `NullReferenceException`

**Meaning:** Code dereferenced a null object.

**Likely causes:**

- Object, property, collection item, service, or deserialized value was null.
- Dependency injection did not provide a dependency.
- `FirstOrDefault` or lookup returned null.
- Test setup missed required state.

**Smallest fix:** Find the exact null value at the failing line, then either initialize it, guard against null, or make the contract nullable.

**Prevention tip:** Enable nullable reference types and write tests for missing optional data.

### `InvalidOperationException`

**Meaning:** The object or operation is in the wrong state for the requested action.

**Likely causes:**

- Calling LINQ `Single`, `First`, or collection operations on invalid data.
- Modifying a collection during enumeration.
- Using a disposed or already-started object.
- Incorrect service lifetime or framework pipeline usage.

**Smallest fix:** Read the exception message closely; it usually names the invalid state. Use `FirstOrDefault`, `SingleOrDefault`, snapshots, or state checks only when that matches the business rule.

**Prevention tip:** Do not replace `Single` with `FirstOrDefault` blindly. Decide whether duplicates or missing values are bugs.

### `ArgumentNullException`

**Meaning:** A method received null for a parameter that does not allow it.

**Likely causes:**

- Caller passed unchecked external input.
- Configuration or DI value is missing.
- Test setup omitted a dependency.

**Smallest fix:** Check at the boundary, provide a valid value, or update the method contract if null should be allowed.

**Prevention tip:** Use guard clauses at public boundaries and constructors.

### `ArgumentException` and `ArgumentOutOfRangeException`

**Meaning:** A parameter value is present but invalid.

**Likely causes:**

- Negative amount, invalid enum, empty string, invalid index, or unsupported option.
- Domain rule is enforced too late.

**Smallest fix:** Validate before calling, or move validation into the type/method that owns the rule.

**Prevention tip:** Test boundary values, not only typical values.

### `IndexOutOfRangeException` and `ArgumentOutOfRangeException` for indexes

**Meaning:** Code accessed a position outside an array, list, span, string, or collection.

**Likely causes:**

- Off-by-one loop condition.
- Empty collection.
- Assumed split/string shape.
- Collection changed size.

**Smallest fix:** Use `< Count` instead of `<= Count`, check for empty collections, or validate input shape.

**Prevention tip:** Prefer `foreach` when the index is not needed.

### `FormatException`

**Meaning:** A string could not be parsed into the requested format.

**Likely causes:**

- Invalid number, date, GUID, or enum input.
- Culture-specific decimal/date format.
- Empty string.

**Smallest fix:** Use `TryParse`, specify culture for machine-readable formats, and return a useful validation error.

**Prevention tip:** Use `InvariantCulture` for machine-readable data and current culture for user-facing input when appropriate.

### `TaskCanceledException` and `OperationCanceledException`

**Meaning:** An operation was canceled or timed out.

**Likely causes:**

- HTTP request timeout.
- CancellationToken was canceled by caller.
- Background operation exceeded a timeout.
- Cancellation is treated as an error instead of expected flow.

**Smallest fix:** Check which token or timeout canceled the operation. Handle expected cancellation separately from failures.

**Prevention tip:** Pass cancellation tokens consistently and log cancellation differently from unexpected exceptions.

### `ObjectDisposedException`

**Meaning:** Code used an object after it was disposed.

**Likely causes:**

- Returning a stream, DbContext-backed query, or reader after a `using` block.
- Capturing a scoped service in a singleton or background task.
- Disposing HttpClient or services that should be reused through DI.

**Smallest fix:** Keep usage inside the lifetime, materialize needed data before disposal, or fix DI lifetimes.

**Prevention tip:** Review ownership: the code that creates a disposable object usually owns disposing it, unless DI owns it.

### `JsonException`

**Meaning:** JSON could not be parsed or converted to the requested .NET type.

**Likely causes:**

- Invalid JSON syntax.
- Property type mismatch.
- Missing converter for custom format.
- Case/name mismatch or unexpected null.

**Smallest fix:** Inspect the path/line in the exception, adjust DTO types/options, or add a converter only when the format truly differs.

**Prevention tip:** Keep DTOs close to the JSON contract and test representative payloads.

## Debugging Guardrails

- Do not guess from the error code alone when code is available.
- Ask for the exact error text and the failing line when they are missing and materially needed.
- For compiler errors, identify the type/scope mismatch before suggesting broad rewrites.
- For runtime exceptions, identify the failing expression and the first user-code stack frame.
- For nullable warnings, prefer contract fixes over suppression.
- For async cancellation, distinguish expected cancellation from unexpected failure.
