import 'package:ln_studio/src/feature/profile/model/booking.dart';
import 'package:ln_studio/src/feature/profile/model/profile.dart';

import 'profile_data_provider.dart';

/// Repository for employee data.
abstract interface class ProfileRepository {
  /// Get employee by id.
  Future<List<BookingModel>> getAllBookings();

  ///
  Future<ProfileModel> getProfile();

  ///
  Future<ProfileModel> editProfile(ProfileModel profile);

  /// Добавить отзыв
  Future<void> addReview({
    required int bookingId,
    required String text,
  });
}

/// Implementation of the employee repository.
final class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._dataSource);

  /// Employee data provider.
  final ProfileDataProvider _dataSource;

  @override
  Future<List<BookingModel>> getAllBookings() => _dataSource.fetchAllBookings();

  @override
  Future<ProfileModel> getProfile() => _dataSource.getProfile();

  @override
  Future<ProfileModel> editProfile(ProfileModel profile) =>
      _dataSource.editProfile(profile);

  @override
  Future<void> addReview({
    required int bookingId,
    required String text,
  }) =>
      _dataSource.addReview(
        bookingId: bookingId,
        text: text,
      );
}
