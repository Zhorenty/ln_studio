import '/src/feature/initialization/model/dependencies.dart';
import '/src/feature/initialization/model/initialization_hook.dart';
import '/src/feature/initialization/model/initialization_progress.dart';
import 'initialization_steps.dart';

/// Handles the initialization process.
mixin InitializationProcessor {
  Future<InitializationResult> processInitialization({
    required Map<String, StepAction> steps,
    required InitializationHook hook,
  }) async {
    final stopwatch = Stopwatch()..start();
    var stepCount = 0;

    final progress = InitializationProgress();

    hook.onInit?.call();
    try {
      await for (final step in Stream.fromIterable(steps.entries)) {
        stepCount++;
        final stopWatch = Stopwatch()..start();
        await step.value(progress);
        hook.onInitializing?.call(
          InitializationStepInfo(
            stepName: step.key,
            step: stepCount,
            stepsCount: steps.length,
            msSpent: (stopWatch..stop()).elapsedMilliseconds,
          ),
        );
      }
    } on Object catch (e) {
      hook.onError?.call(stepCount, e);
      rethrow;
    }
    stopwatch.stop();
    final result = InitializationResult(
      dependencies: progress.freeze(),
      stepCount: stepCount,
      msSpent: stopwatch.elapsedMilliseconds,
    );
    hook.onInitialized?.call(result);
    return result;
  }
}

/// Handles information about initialization process.
class InitializationStepInfo {
  const InitializationStepInfo({
    required this.stepName,
    required this.step,
    required this.stepsCount,
    required this.msSpent,
  });

  /// Current step number.
  final int step;

  /// Name of current step.
  final String stepName;

  /// Total number of steps.
  final int stepsCount;

  /// Time spent on current step in milliseconds.
  final int msSpent;
}
