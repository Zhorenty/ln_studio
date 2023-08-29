import 'package:flutter/material.dart';

import '../utils/mixin/scope_mixin.dart';

typedef BuildScope<T extends Widget> = Widget Function(Widget child);

/// Creates an argument error for a null child that must not be null.
Never _childIsNull() => throw ArgumentError.notNull('child');

/// Widget that provides a scope to its child.
class ScopeProvider<T extends Widget> extends StatelessWidget {
  const ScopeProvider({required this.buildScope, this.child, super.key});

  /// Builds the widget.
  final BuildScope<T> buildScope;

  /// Widget that will be provided with the scope.
  final Widget? child;

  @override
  Widget build(BuildContext context) => buildScope(child ?? _childIsNull());
}

/// Widget that provides a list of scopes to its descendants.
class ScopesProvider extends StatelessWidget with ScopeMixin {
  const ScopesProvider({
    required this.child,
    required this.providers,
    super.key,
  });

  /// Widget below this widget in the tree.
  @override
  final Widget child;

  /// List of scopes to provide to descendants.
  final List<ScopeProvider> providers;

  @override
  Widget build(BuildContext context) => providers.reversed.fold<Widget>(
        child,
        (previousValue, element) => element.buildScope(previousValue),
      );
}
