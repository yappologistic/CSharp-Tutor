# Security Review Map

Use this reference when reviewing C# code that handles untrusted input, web/API requests, data access, files, secrets, logging, serialization, authentication, authorization, or dependencies.

## Pattern to Risk Map

| Code Pattern | Possible Risk | Safer Direction |
| --- | --- | --- |
| SQL built with string concatenation or interpolation | SQL injection | Parameterized queries, EF Core parameters, stored procedures with parameters. |
| User-controlled file paths | Path traversal or unsafe overwrite | Normalize paths, constrain to an allowed root, reject traversal, use safe file names. |
| Dynamic shell/process commands | Command injection | Avoid shell invocation; pass arguments safely; whitelist operations. |
| Deserializing untrusted polymorphic data | Object injection or unexpected type activation | Avoid dangerous type metadata, use strict DTOs, validate payloads. |
| Logging requests, headers, tokens, or exceptions blindly | Secret or PII leakage | Redact sensitive values and log structured, minimal context. |
| Missing authorization checks in handlers/services | Broken access control | Check authorization at the server boundary and again before sensitive operations when needed. |
| Client-provided IDs without ownership checks | Insecure direct object reference | Verify the current principal can access the resource. |
| Model binding directly to domain/entity types | Over-posting or mass assignment | Use request DTOs and map allowed fields explicitly. |
| Weak or custom cryptography | Data exposure | Use current framework cryptographic APIs and official guidance. |
| Secrets in source, config files, or tests | Credential exposure | Use secret stores, environment-specific config, and rotation. |
| Unbounded upload/request/body processing | Denial of service | Limit size, type, rate, time, and resource usage. |
| Old packages or broad transitive dependencies | Known vulnerabilities | Audit dependencies, lock versions when appropriate, update intentionally. |

## Code Examples

### SQL Injection

Risky:

```csharp
var sql = $"SELECT * FROM Users WHERE Email = '{email}'";
var users = db.Users.FromSqlRaw(sql).ToList();
```

Safer:

```csharp
var users = db.Users
    .FromSqlInterpolated($"SELECT * FROM Users WHERE Email = {email}")
    .ToList();
```

Or prefer LINQ when possible:

```csharp
var users = await db.Users.Where(u => u.Email == email).ToListAsync();
```

### Path Traversal

Risky:

```csharp
var path = Path.Combine(root, request.FileName);
return Results.File(path);
```

Safer:

```csharp
var rootPath = Path.GetFullPath(root);
var requestedPath = Path.GetFullPath(Path.Combine(rootPath, request.FileName));

if (!requestedPath.StartsWith(rootPath, StringComparison.Ordinal))
{
    return Results.BadRequest();
}

return Results.File(requestedPath);
```

### Over-Posting

Risky:

```csharp
app.MapPost("/users", async (User user, AppDbContext db) =>
{
    db.Users.Add(user);
    await db.SaveChangesAsync();
});
```

Safer:

```csharp
public sealed record CreateUserRequest(string Email, string DisplayName);

app.MapPost("/users", async (CreateUserRequest request, AppDbContext db) =>
{
    var user = new User
    {
        Email = request.Email,
        DisplayName = request.DisplayName
    };

    db.Users.Add(user);
    await db.SaveChangesAsync();
});
```

### Logging Secrets

Risky:

```csharp
logger.LogInformation("Login request {@Request}", request);
```

Safer:

```csharp
logger.LogInformation("Login attempt for {Email}", request.Email);
```

Never log passwords, bearer tokens, API keys, cookies, or full authorization headers.

## Review Steps

1. Identify trust boundaries: user input, network, files, database, queues, environment, and third-party APIs.
2. Trace sensitive data: secrets, tokens, personal data, auth claims, payment data, and business-sensitive fields.
3. Check authentication separately from authorization.
4. Check ownership: the current principal must be allowed to access the specific resource ID.
5. Check failure modes: errors, retries, timeouts, cancellation, logging, and fallback behavior.
6. Recommend tests: unauthorized access, malicious input, traversal attempts, oversized payloads, and dependency scanning.

## Language for Findings

- Say "possible risk" when exploitability depends on missing context.
- Name the weakness class with OWASP or MITRE CWE when useful.
- Provide a concrete safer C# pattern, not only a warning.
- Prefer official Microsoft, OWASP, MITRE, and NuGet guidance for source-backed claims.
