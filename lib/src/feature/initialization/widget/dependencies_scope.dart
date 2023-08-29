import 'package:flutter/material.dart';

import '../model/dependencies.dart';
import '/src/common/utils/mixin/scope_mixin.dart';

/// Container for all the dependencies
abstract class StoresContainer {
  Dependencies get dependencies;
}

/// {@template dependencies_scope}
/// Widget which is responsible for providing the dependencies.
/// {@endtemplate}
class DependenciesScope extends InheritedWidget
    with ScopeMixin
    implements StoresContainer {
  /// {@macro dependencies_scope}
  const DependenciesScope({
    required super.child,
    required this.dependencies,
    super.key,
  });

  @override
  final Dependencies dependencies;

  /// The state from the closest instance of this class
  /// that encloses the given context.
  ///
  /// e.g. `DependenciesScope.of(context)`
  static Dependencies of(BuildContext context) =>
      _maybeOf(context)?.dependencies ??
      ScopeMixin.notFoundInheritedWidgetOfExactType<DependenciesScope>();

  /// Maybe get the dependencies from the widget
  ///
  /// The dependencies may not be present if they are not provided higher up
  /// in the tree.
  static StoresContainer? _maybeOf(BuildContext context) =>
      ScopeMixin.scopeMaybeOf<DependenciesScope>(context, listen: false);

  @override
  bool updateShouldNotify(DependenciesScope oldWidget) => false;
}
