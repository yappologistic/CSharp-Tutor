# Exercise Guidance

Use exercises when the user is learning a concept, asks for practice, or would benefit from applying feedback to their own code.

## Exercise Design Heuristic

Good exercises are small, runnable, and checkable. Include:

1. Task.
2. Starter code when useful.
3. Expected behavior.
4. One hint.
5. Optional stretch.
6. Solution only when the user asks or `reveal=true`.

Avoid exercises that require a full project unless the user asks for a project.

## Drill Hints

Honor `drill=...`:

- `drill=string-parsing`: parsing, validation, culture, edge cases.
- `drill=collections`: list/dictionary/set choice, mutation, equality.
- `drill=linq`: filtering, projection, grouping, joins, deferred execution.
- `drill=oop-modeling`: classes, interfaces, encapsulation, responsibilities.
- `drill=unit-tests`: arrange/act/assert, edge cases, regression tests.
- `drill=async`: async I/O, cancellation, exception flow.
- `drill=refactoring`: preserve behavior while improving structure.
- `drill=security`: validation, paths, secrets, auth, serialization, logging.
- `drill=performance`: measurement, allocations, data structures, I/O.

## Ready-To-Use Exercises

### Beginner: String Parsing

Task: Write `TryParseAge(string input, out int age)` that accepts whole numbers from 0 to 120.

Starter:

```csharp
static bool TryParseAge(string input, out int age)
{
    // Your code here
}
```

Expected behavior:

- `"42"` returns `true` and `42`.
- `"-1"`, `"121"`, `"abc"`, and `""` return `false`.

Hint: Use `int.TryParse` first, then range-check the result.

### Intermediate: Collections

Task: Given a list of orders, return the unique customer IDs that have at least one unpaid order.

Starter:

```csharp
public sealed record Order(int CustomerId, bool IsPaid);

static IReadOnlySet<int> GetCustomersWithUnpaidOrders(IEnumerable<Order> orders)
{
    // Your code here
}
```

Expected behavior: duplicate customer IDs appear only once.

Hint: A `HashSet<int>` communicates uniqueness and gives fast lookups.

### Intermediate: LINQ Deferred Execution

Task: Fix this method so the expensive query runs only once.

```csharp
static void PrintLargeOrders(IEnumerable<Order> orders)
{
    var large = orders.Where(o => o.Total > 1_000);

    Console.WriteLine($"Found {large.Count()} orders");
    foreach (var order in large)
    {
        Console.WriteLine(order.Id);
    }
}
```

Expected behavior: same output, one enumeration.

Hint: Materialize when you need to count and iterate.

### Intermediate: Async Cancellation

Task: Add cancellation support to this method.

```csharp
static async Task<string> DownloadAsync(HttpClient client, string url)
{
    return await client.GetStringAsync(url);
}
```

Expected behavior: callers can cancel the request.

Hint: Add a `CancellationToken` parameter and pass it to async APIs that accept it.

### Review Practice: Security

Task: Make this file-loading method reject path traversal.

```csharp
static string LoadUserFile(string root, string relativePath)
{
    var path = Path.Combine(root, relativePath);
    return File.ReadAllText(path);
}
```

Expected behavior:

- `"notes.txt"` under the root is allowed.
- `"../secrets.txt"` is rejected.

Hint: Normalize the full path before checking whether it stays under the allowed root.

### Refactoring Practice

Task: Split this method into smaller methods without changing behavior.

```csharp
static decimal CalculateInvoiceTotal(IEnumerable<LineItem> items, decimal taxRate)
{
    decimal subtotal = 0;
    foreach (var item in items)
    {
        subtotal += item.Quantity * item.UnitPrice;
    }

    var tax = subtotal * taxRate;
    return subtotal + tax;
}
```

Expected behavior: same total for the same inputs.

Hint: Extract subtotal calculation first.

## Solution Policy

When giving a solution, keep it compact and explain one transferable idea. For example:

```text
The key move is using TryParse before range checks. That separates "is this a number?" from "is this an allowed age?"
```

For learners, ask them to predict one edge case before showing the final answer.
