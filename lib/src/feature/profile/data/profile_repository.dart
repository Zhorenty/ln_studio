import 'package:ln_studio/src/feature/profile/model/booking.dart';
import 'package:ln_studio/src/feature/profile/model/profile.dart';

import 'profile_data_provider.dart';

/// Repository for employee data.
abstract interface class ProfileRepository {
  /// Get employee by id.
  Future<List<BookingModel>> getAllBookings();

  Future<void> saveProfile(ProfileModel profile);

  ProfileModel? getProfile();
}

/// Implementation of the employee repository.
final class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._dataSource);

  /// Employee data provider.
  final ProfileDataProvider _dataSource;

  @override
  Future<List<BookingModel>> getAllBookings() => _dataSource.fetchAllBookings();

  @override
  ProfileModel? getProfile() => _dataSource.getProfile();

  @override
  Future<void> saveProfile(ProfileModel profile) =>
      _dataSource.saveProfile(profile);
}
