import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widget/scope_widgets.dart';
import '/src/feature/initialization/widget/dependencies_scope.dart';
import '/src/feature/initialization/model/dependencies.dart';
import '/src/feature/wardrobe/bloc/wardrobe_bloc.dart';
import '/src/feature/wardrobe/bloc/wardrobe_event.dart';
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
            create: (context) => WardrobeBloc(
                wardrobeRepository: result.dependencies.wardrobeRepository)
              ..add(const WardrobeEvent.load()),
          )
        ],
        child: ScopesProvider(
          providers: [
            ScopeProvider(
              buildScope: (child) => DependenciesScope(
                dependencies: result.dependencies,
                child: child,
              ),
            ),
          ],
          child: const AppContext(),
        ),
      );
}
