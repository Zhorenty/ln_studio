import 'package:ln_studio/src/feature/auth/data/auth_repository.dart';
import 'package:ln_studio/src/feature/home/data/home_repository.dart';
import 'package:ln_studio/src/feature/profile/data/profile_repository.dart';
import 'package:ln_studio/src/feature/record/data/record_repository.dart';
import 'package:rest_client/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/src/feature/salon/data/salon_repository.dart';

/// Dependencies container.
abstract interface class Dependencies {
  /// Shared preferences
  abstract final SharedPreferences sharedPreferences;

  /// [RestClient] instance.
  abstract final RestClient restClient;

  ///
  abstract final AuthRepository authRepository;

  /// Salon  repository.
  abstract final SalonRepository salonRepository;

  /// Home  repository.
  abstract final HomeRepository homeRepository;

  /// Record repository.
  abstract final RecordRepository recordRepository;

  ///
  abstract final ProfileRepository profileRepository;

  /// Freeze dependencies, so they cannot be modified.
  Dependencies freeze();
}

/// Mutable version of dependencies.
///
/// Used to build dependencies.
final class Dependencies$Mutable implements Dependencies {
  Dependencies$Mutable();

  @override
  late SharedPreferences sharedPreferences;

  @override
  late RestClient restClient;

  @override
  late AuthRepository authRepository;

  @override
  late SalonRepository salonRepository;

  @override
  late HomeRepository homeRepository;

  @override
  late RecordRepository recordRepository;

  @override
  late ProfileRepository profileRepository;

  @override
  Dependencies freeze() => _Dependencies$Immutable(
        sharedPreferences: sharedPreferences,
        restClient: restClient,
        authRepository: authRepository,
        salonRepository: salonRepository,
        homeRepository: homeRepository,
        recordRepository: recordRepository,
        profileRepository: profileRepository,
      );
}

/// Immutable version of dependencies.
///
/// Used to store dependencies.
final class _Dependencies$Immutable implements Dependencies {
  const _Dependencies$Immutable({
    required this.sharedPreferences,
    required this.restClient,
    required this.authRepository,
    required this.salonRepository,
    required this.homeRepository,
    required this.recordRepository,
    required this.profileRepository,
  });

  @override
  final SharedPreferences sharedPreferences;

  @override
  final RestClient restClient;

  @override
  final AuthRepository authRepository;

  @override
  final SalonRepository salonRepository;

  @override
  final HomeRepository homeRepository;

  @override
  final RecordRepository recordRepository;

  @override
  final ProfileRepository profileRepository;

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
