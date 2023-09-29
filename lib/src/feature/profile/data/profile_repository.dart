import 'package:ln_studio/src/feature/profile/model/booking.dart';

import 'profile_data_provider.dart';

/// Repository for employee data.
abstract interface class ProfileRepository {
  /// Get employee by id.
  Future<List<BookingModel>> getAllBookings();
}

/// Implementation of the employee repository.
final class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._dataSource);

  /// Employee data provider.
  final ProfileDataProvider _dataSource;

  @override
  Future<List<BookingModel>> getAllBookings() => _dataSource.fetchAllBookings();
}
