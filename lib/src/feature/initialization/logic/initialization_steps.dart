import 'dart:async';

import 'package:database/database.dart';

import '/src/common/router/router.dart';
import '/src/feature/initialization/model/initialization_progress.dart';
import '/src/feature/wardrobe/data/wardrobe_data_source.dart';
import '/src/feature/wardrobe/data/wardrobe_repository.dart';

typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

/// Handles initialization steps.
mixin InitializationSteps {
  final initializationSteps = <String, StepAction>{
    'Router': (progress) {
      final router = AppRouter();
      return progress.dependencies.router = router;
    },
    'Database': (progress) {
      final database = AppDatabase(name: 'ln_studio');
      return progress.dependencies.database = database;
    },
    'Wardrobe repository': (progress) {
      final wardrobeRepository = WardrobeRepositoryImpl(
        WardrobeDao(progress.dependencies.database),
      );
      return progress.dependencies.wardrobeRepository = wardrobeRepository;
    }
  };
}
