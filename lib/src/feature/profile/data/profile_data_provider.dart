import 'package:dio/dio.dart';

import '/src/common/utils/extensions/date_time_extension.dart';
import '/src/feature/profile/model/booking.dart';
import '../model/profile.dart';

/// Datasource for profile data.
abstract interface class ProfileDataProvider {
  ///
  Future<ProfileModel> getProfile();

  ///
  Future<ProfileModel> editProfile(ProfileModel profile);

  /// Fetch .
  Future<List<BookingModel>> fetchAllBookings();
}

/// Implementation of employee datasource.
class ProfileDataProviderImpl implements ProfileDataProvider {
  ProfileDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final Dio restClient;

  @override
  Future<ProfileModel> getProfile() async {
    final response = await restClient.get('/api/auth/client');

    return ProfileModel.fromJson(
      (response.data['data'] as Map<String, dynamic>)['user'],
    );
  }

  @override
  Future<ProfileModel> editProfile(ProfileModel user) async {
    final response = await restClient.put(
      '/api/v1/user/${user.id}/edit',
      data: {
        'first_name': user.firstName,
        'last_name': user.lastName,
        'birth_date': user.birthDate.jsonFormat(),
        'email': user.email,
      },
    );

    return ProfileModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<BookingModel>> fetchAllBookings() async {
    final response = await restClient.get('/api/v1/service_sale');

    final bookings = List.from((response.data['data'] as List))
        .map((e) => BookingModel.fromJson(e))
        .toList();

    return bookings;
  }
}
