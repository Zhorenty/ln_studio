import 'package:flutter/material.dart';

import '/src/common/router/app_router_scope.dart';
import '/src/common/widget/scope_widgets.dart';
import '/src/feature/initialization/widget/dependencies_scope.dart';
import '/src/feature/initialization/model/dependencies.dart';
import 'app_context.dart';

/// {@template app}
/// App widget.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({required this.result, super.key});

  void run() => runApp(this);

  /// Handles initialization result.
  final InitializationResult result;

  @override
  Widget build(BuildContext context) => ScopesProvider(
        providers: [
          ScopeProvider(
            buildScope: (child) => DependenciesScope(
              dependencies: result.dependencies,
              child: child,
            ),
          ),
          ScopeProvider(
            buildScope: (child) => AppRouterScope(
              child: child,
            ),
          ),
        ],
        child: const AppContext(),
      );
}
