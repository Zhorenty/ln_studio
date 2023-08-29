import 'package:flutter/material.dart';

/// Container for all the child's.
abstract class ChildContainer {
  Widget? get child;
}

/// Mixin which provides some useful methods for working with inherited widgets.
/// If you need to get a scope from the context, use [scopeMaybeOf] or [scopeOf].
/// Also, use this Mixin if you want to provide a scope to descendants.
mixin ScopeMixin<T extends Widget> on Widget implements ChildContainer {
  static T? scopeMaybeOf<T extends InheritedWidget>(
    BuildContext context, {
    bool listen = true,
  }) {
    T? inhW;
    if (listen) {
      inhW = context.dependOnInheritedWidgetOfExactType<T>();
    } else {
      inhW = context.getElementForInheritedWidgetOfExactType<T>()?.widget as T?;
    }
    return inhW;
  }

  /// Get the scope from the context, throwing an error if it's not found.
  static T scopeOf<T extends InheritedWidget>(
    BuildContext context, {
    bool listen = true,
  }) =>
      scopeMaybeOf<T>(context, listen: listen) ??
      notFoundInheritedWidgetOfExactType<T>();

  /// Throw an [ArgumentError] when an inherited widget of the exact type
  /// specified by the generic type parameter T is not found.
  static Never
      notFoundInheritedWidgetOfExactType<T extends InheritedWidget>() =>
          throw ArgumentError(
            'Out of scope, not found inherited widget '
                'a $T of the exact type',
            'out_of_scope',
          );
}
