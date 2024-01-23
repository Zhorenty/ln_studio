import 'package:ln_studio/src/feature/home/data/home_data_provider.dart';
import 'package:ln_studio/src/feature/home/model/news.dart';
import 'package:ln_studio/src/feature/home/model/review.dart';

/// Repository for Record data.
abstract interface class HomeRepository {
  /// Get RecordRecordDataProvider
  Future<List<NewsModel>> getNews();

  /// Fetch reviews
  Future<List<Review>> fetchReviews(int employeeId);
}

/// Implementation of the Record repository.
final class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._dataProvider);

  /// Record data source.
  final HomeDataProvider _dataProvider;

  @override
  Future<List<NewsModel>> getNews() => _dataProvider.fetchNews();

  @override
  Future<List<Review>> fetchReviews(int employeeId) =>
      _dataProvider.fetchReviews(employeeId);
}
