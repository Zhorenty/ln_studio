import 'package:shared_preferences/shared_preferences.dart';

import '/src/common/router/router.dart';

/// Dependencies container.
abstract interface class Dependencies {
  /// App router.
  abstract final AppRouter router;

  /// Shared preferences
  abstract final SharedPreferences sharedPreferences;

  /// Freeze dependencies, so they cannot be modified.
  Dependencies freeze();
}

/// Mutable version of dependencies.
///
/// Used to build dependencies.
final class Dependencies$Mutable implements Dependencies {
  Dependencies$Mutable();

  @override
  late AppRouter router;

  @override
  late SharedPreferences sharedPreferences;

  @override
  Dependencies freeze() => _Dependencies$Immutable(
        router: router,
        sharedPreferences: sharedPreferences,
      );
}

/// Immutable version of dependencies.
///
/// Used to store dependencies.
final class _Dependencies$Immutable implements Dependencies {
  const _Dependencies$Immutable({
    required this.router,
    required this.sharedPreferences,
  });

  @override
  final AppRouter router;

  @override
  final SharedPreferences sharedPreferences;

  @override
  Dependencies freeze() => this;
}

/// Handles initialization result.
final class InitializationResult {
  const InitializationResult({
    required this.dependencies,
    required this.stepCount,
    required this.msSpent,
  });

  /// Dependencies container.
  final Dependencies dependencies;

  /// Total number of steps.
  final int stepCount;

  /// Time spent on current step in milliseconds.
  final int msSpent;
}
