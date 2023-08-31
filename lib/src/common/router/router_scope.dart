import 'package:flutter/material.dart';

import '/src/common/utils/mixin/scope_mixin.dart';
import 'router.dart';

/// Widget which is responsible for providing the [AppRouter].
class AppRouterScope extends StatefulWidget with ScopeMixin {
  const AppRouterScope({required this.child, super.key});

  @override
  final Widget child;

  /// Returns the [AppRouter] from the closest [AppRouterScope] ancestor.
  static AppRouter of(BuildContext context, {bool listen = true}) =>
      ScopeMixin.scopeOf<_AppRouterInherited>(context, listen: listen).router;

  @override
  State<AppRouterScope> createState() => _AppRouterScopeState();
}

/// {@nodoc}
class _AppRouterScopeState extends State<AppRouterScope> {
  /// {@nodoc}
  late final AppRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter();
  }

  @override
  Widget build(BuildContext context) => _AppRouterInherited(
        router: _router,
        child: widget.child,
      );
}

/// {@nodoc}
class _AppRouterInherited extends InheritedWidget {
  const _AppRouterInherited({required this.router, required super.child});

  /// {@nodoc}
  final AppRouter router;

  @override
  bool updateShouldNotify(_AppRouterInherited oldWidget) =>
      oldWidget.router != router;
}
