import 'package:dio/dio.dart';
import 'package:ln_studio/src/common/utils/extensions/date_time_extension.dart';
import 'package:ln_studio/src/feature/profile/model/booking.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';

import '../model/profile.dart';

/// Datasource for profile data.
abstract interface class ProfileDataProvider {
  ///
  UserModel getProfile();

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
  UserModel getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
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

    /// TODO: Didn't working, need to
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
