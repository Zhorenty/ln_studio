import 'package:ln_studio/src/feature/profile/model/booking.dart';
import 'package:ln_studio/src/feature/profile/model/profile.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';

import 'profile_data_provider.dart';

/// Repository for employee data.
abstract interface class ProfileRepository {
  /// Get employee by id.
  Future<List<BookingModel>> getAllBookings();

  UserModel getProfile();

  Future<ProfileModel> editProfile(ProfileModel profile);
}

/// Implementation of the employee repository.
final class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._dataSource);

  /// Employee data provider.
  final ProfileDataProvider _dataSource;

  @override
  Future<List<BookingModel>> getAllBookings() => _dataSource.fetchAllBookings();

  @override
  UserModel getProfile() => _dataSource.getProfile();

  @override
  Future<ProfileModel> editProfile(ProfileModel profile) =>
      _dataSource.editProfile(profile);
}
