import 'package:ln_studio/src/common/utils/extensions/date_time_extension.dart';
import 'package:ln_studio/src/feature/profile/model/booking.dart';
import 'package:ln_studio/src/feature/profile/model/profile.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:rest_client/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Datasource for profile data.
abstract interface class ProfileDataProvider {
  ///
  Future<void> saveProfile(ProfileModel profile);

  ///
  ProfileModel? getProfile();

  Future<UserModel> editProfile(UserModel profile);

  /// Fetch .
  Future<List<BookingModel>> fetchAllBookings();
}

/// Implementation of employee datasource.
class ProfileDataProviderImpl implements ProfileDataProvider {
  ProfileDataProviderImpl({
    required this.restClient,
    required this.sharedPreferences,
  });

  /// REST client to call API.
  final RestClient restClient;

  final SharedPreferences sharedPreferences;

  static const String key = 'profile';

  @override
  Future<void> saveProfile(ProfileModel profile) async =>
      await sharedPreferences.setString(key, profile.toJson() as String);

  @override
  ProfileModel? getProfile() {
    final jsonString = sharedPreferences.getString(key);

    if (jsonString != null) {
      return ProfileModel.fromJson(jsonString as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<UserModel> editProfile(UserModel user) async {
    final response = await restClient.put(
      '/api/v1/user/${user.id}/edit',
      body: {
        'first_name': user.firstName,
        'last_name': user.lastName,
        'birth_date': user.birthDate.jsonFormat(),
        'email': user.email,
      },
    );

    return UserModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<BookingModel>> fetchAllBookings() async {
    final response = await restClient.get('/api/v1/service_sale');

    final bookings = List.from((response['data'] as List))
        .map((e) => BookingModel.fromJson(e))
        .toList();

    return bookings;
  }
}
