# Blazor Guidance

Use this reference for Blazor component, app architecture, debugging, performance, and review questions.

## Identify The Model

Clarify whether the app uses Blazor Server, Blazor WebAssembly, or Blazor Web App rendering modes. Behavior, latency, hosting, auth, and deployment guidance change materially.

## Review Priorities

- Component lifecycle: `OnInitialized`, `OnParametersSet`, `OnAfterRender`, async variants, and disposal.
- State ownership: local component state, cascading values, scoped services, browser storage, URL state, and server-side circuit state.
- Rendering: avoid unnecessary `StateHasChanged`, expensive work during render, and unstable keys in lists.
- Forms and validation: model binding, validation messages, edit context lifetime, and server validation.
- JS interop: cancellation, disposal, serialization boundaries, and avoiding DOM ownership conflicts.
- Security: auth state, authorization views, server-side enforcement, antiforgery for endpoints, and untrusted browser input.
- Performance: payload size, render frequency, virtualization, streaming, and server circuit scale.

## Common Fixes

- Move expensive work out of render paths.
- Dispose event handlers, timers, subscriptions, and JS object references.
- Use `@key` when preserving element or component identity in changing lists.
- Keep shared state explicit and scoped to the right lifetime.
- Enforce authorization on the server even when the UI hides actions.

## Response Pattern

Start with the Blazor model and the specific component or flow. Explain lifecycle and state interactions before style feedback. Include a small test or manual validation path when practical.
