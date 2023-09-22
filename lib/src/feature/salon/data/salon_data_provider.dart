import 'dart:async';

import '/src/feature/salon/models/salon.dart';
import 'package:rest_client/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstract interface class for providing salon data.
abstract class SalonDataProvider {
  /// Fetches a list of salons.
  ///
  /// Returns a Future that completes with a List of Salon objects.
  Future<List<Salon>> fetchSalons();

  /// Saves the current salon ID.
  ///
  /// Takes an integer [id] as input and returns a Future that completes with void.
  FutureOr<void> saveCurrentSalonId(int id);

  /// Gets the current salon ID.
  ///
  /// Returns a FutureOr that completes with an integer or null if the salon ID is not set.
  FutureOr<int?> getCurrentSalonId();
}

/// Implementation class for providing salon data.
class SalonDataProviderImpl implements SalonDataProvider {
  /// Constructs a SalonDataProviderImpl instance.
  ///
  /// Requires a RestClient and SharedPreferences instance.
  const SalonDataProviderImpl({
    required RestClient restClient,
    required SharedPreferences prefs,
  })  : _restClient = restClient,
        _prefs = prefs;

  final RestClient _restClient;
  final SharedPreferences _prefs;
  final currentSalonIdDBKey = 'currentSalon';

  @override
  Future<List<Salon>> fetchSalons() async {
    final response = await _restClient.get('/api/salon/all');
    final salons = List.from(response['data'] as List)
        .map((e) => Salon.fromJson(e))
        .toList();
    return salons;
  }

  @override
  FutureOr<int?> getCurrentSalonId() => _prefs.getInt(currentSalonIdDBKey);

  @override
  FutureOr<void> saveCurrentSalonId(int id) =>
      _prefs.setInt(currentSalonIdDBKey, id);
}
