import 'package:ln_studio/src/feature/profile/model/booking.dart';
import 'package:rest_client/rest_client.dart';

/// Datasource for employee data.
abstract interface class ProfileDataProvider {
  /// Fetch employee by id.
  Future<List<BookingModel>> fetchAllBookings();
}

/// Implementation of employee datasource.
class ProfileDataProviderImpl implements ProfileDataProvider {
  ProfileDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final RestClient restClient;

  @override
  Future<List<BookingModel>> fetchAllBookings() async {
    final response = await restClient.get('/api/service_sale/all');

    final bookings = List.from((response['data'] as List))
        .map((e) => BookingModel.fromJson(e))
        .toList();

    return bookings;
  }
}
