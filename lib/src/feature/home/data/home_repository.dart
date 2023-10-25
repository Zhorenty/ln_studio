import 'package:ln_studio/src/feature/home/data/home_data_provider.dart';
import 'package:ln_studio/src/feature/home/model/news.dart';

/// Repository for Record data.
abstract interface class HomeRepository {
  /// Get RecordRecordDataProvider
  Future<List<NewsModel>> getNews();
}

/// Implementation of the Record repository.
final class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._dataProvider);

  /// Record data source.
  final HomeDataProvider _dataProvider;

  @override
  Future<List<NewsModel>> getNews() => _dataProvider.fetchNews();
}
