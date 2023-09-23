import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/category/category_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/category/category_event.dart';

import '/src/common/router/app_router_scope.dart';
import '/src/common/widget/scope_widgets.dart';
import '/src/feature/initialization/widget/dependencies_scope.dart';
import '/src/feature/initialization/model/dependencies.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_event.dart';

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
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SalonBLoC(
              repository: result.dependencies.salonRepository,
            )..add(const SalonEvent.fetchAll()),
          ),
          BlocProvider(
            create: (context) => CategoryBloc(
              repository: result.dependencies.recordRepository,
            )..add(const CategoryEvent.fetchCategoryWithServices()),
          ),
        ],
        child: ScopesProvider(
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
        ),
      );
}
