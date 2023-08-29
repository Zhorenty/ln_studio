import '/src/feature/initialization/logic/initialization_processor.dart';
import 'dependencies.dart';

/// A hook for the initialization process.
abstract class InitializationHook {
  InitializationHook({
    this.onInit,
    this.onInitializing,
    this.onInitialized,
    this.onError,
  });

  /// Creates an [InitializationHook] with the specified callback functions.
  factory InitializationHook.setup({
    void Function()? onInit,
    void Function(InitializationStepInfo info)? onInitializing,
    void Function(InitializationResult)? onInitialized,
    void Function(int, Object error)? onError,
  }) = _Hook;

  /// Callback, called before the initialization process starts.
  void Function()? onInit;

  /// Callback, called when the initialization process is in progress.
  void Function(InitializationStepInfo info)? onInitializing;

  /// Callback, called when the initialization process is finished.
  void Function(InitializationResult)? onInitialized;

  /// Callback, called when the initialization process is failed.
  void Function(int, Object error)? onError;
}

/// Concrete [InitializationHook] implementation.
class _Hook extends InitializationHook {
  _Hook({
    super.onInit,
    super.onInitializing,
    super.onInitialized,
    super.onError,
  });
}
