import 'package:dio/dio.dart';
import 'package:ln_studio/src/feature/home/model/news.dart';
import 'package:ln_studio/src/feature/home/model/review.dart';
import 'package:ln_studio/src/feature/profile/model/booking.dart';

/// Datasource for Record HomeDataProvider.
abstract interface class HomeDataProvider {
  /// Fetch RecordHomeDataProvider
  Future<List<NewsModel>> fetchNews();

  /// Fetch reviews
  Future<List<Review>> fetchReviews(int employeeId);
}

/// Implementation of Record RecordDataProvider.
class HomeDataProviderImpl implements HomeDataProvider {
  HomeDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final Dio restClient;

  @override
  Future<List<NewsModel>> fetchNews() async {
    final response = await restClient.get('/api/v1/news');

    final news = List.from((response.data['data'] as List))
        .map((e) => NewsModel.fromJson(e))
        .toList();

    return news;
  }

  @override
  Future<List<Review>> fetchReviews(int employeeId) async {
    final response =
        await restClient.get('/api/v1/employee/$employeeId/service_sales');

    final employeeBookings = List.from((response.data['data'] as List))
        .map((e) => BookingModel.fromJson(e))
        .toList();
    // TODO: Отрефачить
    final employeeBookingsWithReviews =
        employeeBookings.where((booking) => booking.isHasReview).toList();
    final reviews = employeeBookingsWithReviews.map((e) => e.review!).toList();

    return reviews;
  }
}
