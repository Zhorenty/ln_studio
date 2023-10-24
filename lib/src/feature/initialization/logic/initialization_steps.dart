import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ln_studio/src/feature/auth/data/auth_data_provider.dart';
import 'package:ln_studio/src/feature/auth/data/auth_repository.dart';
import 'package:ln_studio/src/feature/auth/logic/oauth_interceptor.dart';
import 'package:ln_studio/src/feature/profile/data/profile_data_provider.dart';
import 'package:ln_studio/src/feature/profile/data/profile_repository.dart';
import 'package:ln_studio/src/feature/record/data/record_data_provider.dart';
import 'package:ln_studio/src/feature/record/data/record_repository.dart';
import 'package:rest_client/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/src/feature/initialization/model/initialization_progress.dart';
import '/src/feature/salon/data/salon_data_provider.dart';
import '/src/feature/salon/data/salon_repository.dart';

typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

const _baseUrl = 'http://31.129.104.75';

/// Handles initialization steps.
mixin InitializationSteps {
  final initializationSteps = <String, StepAction>{
    'Shared Preferences': (progress) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      progress.dependencies.sharedPreferences = sharedPreferences;
    },
    'Auth Repository & Rest Client': (progress) async {
      final authDataProvider = AuthDataProviderImpl(
        baseUrl: _baseUrl,
        sharedPreferences: progress.dependencies.sharedPreferences,
      );
      final restClient = RestClient(
        Dio(BaseOptions(baseUrl: _baseUrl))
          ..interceptors.add(
            OAuthInterceptor(
              refresh: authDataProvider.refreshTokenPair,
              loadTokens: authDataProvider.getTokenPair,
              clearTokens: authDataProvider.signOut,
            ),
          ),
      );
      progress.dependencies.restClient = restClient;
      final authRepository = AuthRepositoryImpl(
        authDataProvider: authDataProvider,
      );
      progress.dependencies.authRepository = authRepository;
    },
    'Salon repository': (progress) async {
      final salonDataProvider = SalonDataProviderImpl(
        restClient: progress.dependencies.restClient,
        prefs: progress.dependencies.sharedPreferences,
      );
      final salonRepository = SalonRepositoryImpl(salonDataProvider);
      progress.dependencies.salonRepository = salonRepository;
    },
    'Record repository': (progress) async {
      final recordDataProvider = RecordDataProviderImpl(
        restClient: progress.dependencies.restClient,
      );
      final recordRepository = RecordRepositoryImpl(recordDataProvider);
      progress.dependencies.recordRepository = recordRepository;
    },
    'Profile repository': (progress) async {
      final profileDataProvider = ProfileDataProviderImpl(
        restClient: progress.dependencies.restClient,
        sharedPreferences: progress.dependencies.sharedPreferences,
      );
      final profileRepository = ProfileRepositoryImpl(profileDataProvider);
      progress.dependencies.profileRepository = profileRepository;
    },
  };
}
