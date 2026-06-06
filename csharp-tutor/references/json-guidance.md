# C# JSON Guidance

Use this reference for serialization, deserialization, DTOs, records, persistence, and `System.Text.Json`.

## Mental Model

- Serialization converts a C# object into a data format such as JSON.
- Deserialization converts JSON back into a C# object.
- JSON stores data, not behavior.
- The C# type controls the shape expected during deserialization.

## System.Text.Json Basics

Prefer `System.Text.Json` for modern .NET unless the project already uses another serializer.

```csharp
using System.Text.Json;

var person = new Person("Aryan", 22);
string json = JsonSerializer.Serialize(person);
Person? restored = JsonSerializer.Deserialize<Person>(json);
```

## DTOs and Domain Objects

- Use DTOs when the JSON shape should differ from the domain model.
- Keep domain invariants in domain types.
- Avoid letting persistence concerns force weak domain design.
- Records are often useful for simple immutable data and DTOs.

## Common Issues

- Deserialization can return `null`; handle it.
- Property names and casing may need options.
- Constructors, private setters, required members, and records affect deserialization behavior.
- Cycles in object graphs can cause serialization problems.
- Dates, decimals, enums, and culture-sensitive values need deliberate handling.
- Do not deserialize untrusted polymorphic data without strict controls.

## Persistence Guidance

- For beginner console apps, JSON files are acceptable for practice.
- Keep file I/O in a storage/repository class, not inside domain logic.
- Validate loaded data before trusting it.
- Avoid overwriting important files without backups or atomic write strategy in real apps.

## Teaching Shape

When explaining JSON, show:

1. A small C# type.
2. The JSON it becomes.
3. The deserialization code.
4. How to print or inspect the restored values.
5. One common failure case.
