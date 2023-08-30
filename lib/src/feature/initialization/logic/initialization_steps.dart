import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '/src/common/router/router.dart';
import '/src/feature/initialization/model/initialization_progress.dart';

typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

/// Handles initialization steps.
mixin InitializationSteps {
  final initializationSteps = <String, StepAction>{
    'Router': (progress) {
      final router = AppRouter();
      return progress.dependencies.router = router;
    },
    'Shared Preferences': (progress) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      progress.dependencies.sharedPreferences = sharedPreferences;
    },
  };
}
