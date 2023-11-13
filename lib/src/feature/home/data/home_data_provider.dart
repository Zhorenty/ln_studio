import 'package:dio/dio.dart';
import 'package:ln_studio/src/feature/home/model/news.dart';

/// Datasource for Record HomeDataProvider.
abstract interface class HomeDataProvider {
  /// Fetch RecordHomeDataProvider
  Future<List<NewsModel>> fetchNews();

// Future<List>
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
}
