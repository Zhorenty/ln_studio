import 'dart:async';

import '/src/feature/salon/models/salon.dart';
import 'salon_data_provider.dart';

/// Abstract interface class representing a data provider for salon
/// information.
abstract interface class SalonRepository {
  /// Fetches a list of salons.
  Future<List<Salon>> fetchSalons();

  /// Saves the ID of the currently selected salon.
  FutureOr<void> saveCurrentSalonId(int id);

  /// Retrieves the ID of the currently selected salon.
  FutureOr<int?> getCurrentSalonId();
}

/// Concrete implementation of the SalonRepository interface.
///
/// Implementation fetches salon information from a RestClient and
/// stores/retrieves the currently selected salon ID using SharedPreferences.
class SalonRepositoryImpl implements SalonRepository {
  const SalonRepositoryImpl(SalonDataProvider dataProvider)
      : _dataProvider = dataProvider;

  /// Instance to use for data retrieval and storage.
  final SalonDataProvider _dataProvider;

  @override
  Future<List<Salon>> fetchSalons() => _dataProvider.fetchSalons();

  @override
  FutureOr<int?> getCurrentSalonId() => _dataProvider.getCurrentSalonId();

  @override
  FutureOr<void> saveCurrentSalonId(int id) =>
      _dataProvider.saveCurrentSalonId(id);
}
