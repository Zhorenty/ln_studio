import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ln_studio/src/feature/auth/data/auth_data_provider.dart';
import 'package:ln_studio/src/feature/auth/data/auth_repository.dart';
import 'package:ln_studio/src/feature/auth/logic/oauth_interceptor.dart';
import 'package:ln_studio/src/feature/home/data/home_data_provider.dart';
import 'package:ln_studio/src/feature/home/data/home_repository.dart';
import 'package:ln_studio/src/feature/profile/data/profile_data_provider.dart';
import 'package:ln_studio/src/feature/profile/data/profile_repository.dart';
import 'package:ln_studio/src/feature/record/data/record_data_provider.dart';
import 'package:ln_studio/src/feature/record/data/record_repository.dart';
import 'package:ln_studio/src/feature/store/data/product_data_provider.dart';
import 'package:ln_studio/src/feature/store/data/product_respository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/src/feature/initialization/model/initialization_progress.dart';
import '/src/feature/salon/data/salon_data_provider.dart';
import '/src/feature/salon/data/salon_repository.dart';

typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

const kBaseUrl = 'https://ln-studio.ru';

/// Handles initialization steps.
mixin InitializationSteps {
  final initializationSteps = <String, StepAction>{
    'Shared Preferences': (progress) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      progress.dependencies.sharedPreferences = sharedPreferences;
    },
    'Auth Repository & Rest Client': (progress) async {
      final authDataProvider = AuthDataProviderImpl(
        baseUrl: kBaseUrl,
        sharedPreferences: progress.dependencies.sharedPreferences,
      );
      final restClient = Dio(BaseOptions(baseUrl: kBaseUrl))
        ..interceptors.add(
          OAuthInterceptor(
            refresh: authDataProvider.refreshTokenPair,
            loadTokens: authDataProvider.getTokenPair,
            clearTokens: authDataProvider.signOut,
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
    'Home repository': (progress) async {
      final homeDataProvider = HomeDataProviderImpl(
        restClient: progress.dependencies.restClient,
      );
      final homeRepository = HomeRepositoryImpl(homeDataProvider);
      progress.dependencies.homeRepository = homeRepository;
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
      );
      final profileRepository = ProfileRepositoryImpl(profileDataProvider);
      progress.dependencies.profileRepository = profileRepository;
    },
    'Store repository': (progress) async {
      final storeDataProvider = StoreDataProviderImpl(
        progress.dependencies.restClient,
      );
      final storeRepository = StoreRepositoryImpl(storeDataProvider);
      progress.dependencies.storeRepository = storeRepository;
    },
  };
}
