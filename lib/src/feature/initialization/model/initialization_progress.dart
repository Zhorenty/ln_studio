import 'dependencies.dart';

/// Initialization progress
final class InitializationProgress {
  /// Instantiates a new [InitializationProgress]
  InitializationProgress();

  /// Mutable Dependencies
  final dependencies = Dependencies$Mutable();

  /// Freeze dependencies, so they cannot be modified
  Dependencies freeze() => dependencies.freeze();
}
