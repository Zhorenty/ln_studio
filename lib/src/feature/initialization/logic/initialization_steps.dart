import 'dart:async';

import 'package:dio/dio.dart';
import 'package:rest_client/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/src/feature/initialization/model/initialization_progress.dart';
import '/src/feature/salon/data/salon_data_provider.dart';
import '/src/feature/salon/data/salon_repository.dart';

typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

/// Handles initialization steps.
mixin InitializationSteps {
  final initializationSteps = <String, StepAction>{
    'Shared Preferences': (progress) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      progress.dependencies.sharedPreferences = sharedPreferences;
    },
    'Rest Client': (progress) async {
      final restClient = RestClient(
        Dio(BaseOptions(baseUrl: 'http://31.129.104.75')),
      );
      progress.dependencies.restClient = restClient;
    },
    'Salon repository': (progress) async {
      final salonDataProvider = SalonDataProviderImpl(
        restClient: progress.dependencies.restClient,
        prefs: progress.dependencies.sharedPreferences,
      );
      final salonRepository = SalonRepositoryImpl(salonDataProvider);
      progress.dependencies.salonRepository = salonRepository;
    },
  };
}
