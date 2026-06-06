# C# Async Guidance

Use this reference for `async`/`await`, `Task`, cancellation, async tests, and common async bugs.

## Mental Model

- `async` lets a method pause while waiting for asynchronous work.
- `await` waits without blocking the current thread.
- `Task<T>` represents work that will eventually produce `T`.
- Async is most useful for I/O-bound work such as HTTP, files, databases, and timers.

## Common Rules

- Avoid `.Result` and `.Wait()` in application code.
- Avoid `async void` except event handlers.
- Pass `CancellationToken` through APIs that support it.
- Await tasks or deliberately handle background failures.
- Name asynchronous methods with `Async` in normal .NET style.
- Use async all the way through the call chain when possible.

## Common Bugs

- Fire-and-forget tasks hide exceptions.
- Blocking async work can waste threads and sometimes deadlock.
- Missing cancellation can make shutdowns, requests, and long operations hang.
- Running CPU-bound work with async does not make it faster by itself.
- Forgetting `await` can make code run out of order.

## Testing Async

- Async test methods should return `Task`.
- Await the operation under test.
- Test cancellation and failure paths.
- Avoid sleeps when possible; prefer controllable time or synchronization.
