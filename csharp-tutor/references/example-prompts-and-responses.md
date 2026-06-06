# Example Prompts and Response Shapes

Use these examples to match the intended tutoring style. Do not copy them rigidly.

## Beginner Concept

Prompt:

```text
What is a property in C#? Is it just a variable?
```

Response shape:

```text
Direct answer:
A property is not just a variable. It is a member that exposes access to a value through get/set accessors.

Mental model:
Fields store data. Properties are the public surface that controls how other code reads or changes that data.

Example:
[Small class with private field and public property, then auto-property.]

Common mistake:
Do not put heavy work or surprising side effects in simple property getters.

Practice:
Create a `Player` class with a `Name` property that rejects empty names.
```

## Bad Async Code Review

Prompt:

```text
Review this method:
public string Load() => httpClient.GetStringAsync(url).Result;
```

Response shape:

```text
Top finding:
This blocks on async work with `.Result`, which can waste threads and can deadlock in some contexts.

Fix:
Make the method async all the way:
public Task<string> LoadAsync(CancellationToken cancellationToken) =>
    httpClient.GetStringAsync(url, cancellationToken);

Why:
The caller can await without blocking, and cancellation can flow through the I/O operation.

Optional tip:
Name async methods with `Async` when following .NET naming conventions.
```

## ASP.NET Core Security Review

Prompt:

```text
Review this controller action that loads a user by id from the route.
```

Response shape:

```text
Main risk:
Authentication does not prove the current user can access the requested id. Check authorization/ownership before returning data.

Safer pattern:
Use the authenticated principal's subject id or verify the route id belongs to that principal.

Tests:
Add a test where user A requests user B's id and receives 403 or 404 according to the app policy.

Source note:
Use ASP.NET Core authorization guidance for the exact policy/resource pattern.
```

## Modernization Refactor

Prompt:

```text
Can this DTO class be improved with new C# features?
```

Response shape:

```text
Assumption:
Assuming C# 11+ is available.

Before/after:
Show class with settable properties, then record with required members or constructor parameters.

Why:
The new version makes required data explicit and reduces boilerplate.

Compatibility:
Check serializers, ORMs, and public API compatibility before changing existing contracts.
```
