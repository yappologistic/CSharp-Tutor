# MAUI Guidance

Use this reference for .NET MAUI, XAML, MVVM, mobile/desktop app architecture, and platform-specific behavior.

## Identify The App Shape

Clarify target platforms, navigation model, MVVM approach, dependency injection setup, and whether the issue is XAML, binding, lifecycle, platform code, packaging, or performance.

## Review Priorities

- Binding context ownership and `INotifyPropertyChanged` correctness.
- Commands, async command behavior, cancellation, and UI-thread updates.
- Shell navigation routes, query parameters, back stack behavior, and deep links.
- Resource dictionaries, styles, themes, images, fonts, and platform-specific assets.
- Platform-specific code boundaries and handler/custom renderer usage.
- Lifecycle events, permissions, backgrounding, and app resume behavior.
- Startup, layout, image, collection, and binding performance.
- Packaging, signing, target framework, workload, and device/emulator deployment issues.

## Common Fixes

- Keep view models UI-framework-aware only where the project has intentionally chosen that pattern.
- Avoid doing network or disk work directly in constructors or render paths.
- Prefer observable collections and property change notifications for bound state.
- Keep platform-specific code behind small interfaces or partial classes.
- Ask for exact target platform and workload errors before suggesting broad MAUI repair steps.

## Output Pattern

For reviews, group findings by binding/navigation/lifecycle/platform/deployment. Include a small manual verification path because MAUI issues often depend on device or platform behavior.
