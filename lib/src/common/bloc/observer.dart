import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/utils/logger.dart';

/// Observing the behavior of [Bloc] instances.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    final buffer = StringBuffer()
      ..write('Bloc ${bloc.runtimeType} has been created');
    logger.info(buffer.toString());
    super.onCreate(bloc);
  }

  @override
  void onTransition(
    Bloc<Object?, Object?> bloc,
    Transition<Object?, Object?> transition,
  ) {
    final buffer = StringBuffer()
      ..writeln('Bloc: ${bloc.runtimeType} | ${transition.event.runtimeType}')
      ..write('Transition: ${transition.currentState.runtimeType}')
      ..writeln(' -> ${transition.nextState.runtimeType}')
      ..writeln('New State: ${transition.nextState.toString()}');
    logger.info(buffer.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc<Object?, Object?> bloc, Object? event) {
    final buffer = StringBuffer()
      ..writeln('Bloc: ${bloc.runtimeType} | ${event.runtimeType}')
      ..writeln('Event: ${event.toString()}');
    logger.info(buffer.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase<Object?> bloc, Object error, StackTrace stackTrace) {
    logger.error(
      'Bloc: ${bloc.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
