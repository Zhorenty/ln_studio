import 'package:ln_studio/src/feature/profile/model/booking.dart';
import 'package:ln_studio/src/feature/profile/model/profile.dart';
import 'package:rest_client/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Datasource for profile data.
abstract interface class ProfileDataProvider {
  Future<void> saveProfile(ProfileModel profile);

  ProfileModel? getProfile();

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
  Future<List<BookingModel>> fetchAllBookings() async {
    final response = await restClient.get('/api/service_sale/all');

    final bookings = List.from((response['data'] as List))
        .map((e) => BookingModel.fromJson(e))
        .toList();

    return bookings;
  }
}
