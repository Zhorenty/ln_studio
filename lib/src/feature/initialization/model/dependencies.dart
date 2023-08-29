import 'package:database/database.dart';

import '/src/common/router/router.dart';
import '/src/feature/wardrobe/data/wardrobe_repository.dart';

/// Dependencies container.
abstract interface class Dependencies {
  /// App router.
  abstract final AppRouter router;

  /// Database.
  abstract final AppDatabase database;

  /// Wardrobe repository.
  abstract final WardrobeRepository wardrobeRepository;

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
  late AppDatabase database;

  @override
  late WardrobeRepository wardrobeRepository;

  @override
  Dependencies freeze() => _Dependencies$Immutable(
        database: database,
        router: router,
        wardrobeRepository: wardrobeRepository,
      );
}

/// Immutable version of dependencies.
///
/// Used to store dependencies.
final class _Dependencies$Immutable implements Dependencies {
  const _Dependencies$Immutable({
    required this.database,
    required this.router,
    required this.wardrobeRepository,
  });

  @override
  final AppRouter router;

  @override
  final AppDatabase database;

  @override
  final WardrobeRepository wardrobeRepository;

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
