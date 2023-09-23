import 'package:rest_client/rest_client.dart';

import '/src/feature/record/model/category.dart';

/// Datasource for Record RecordDataProvider.
abstract interface class RecordDataProvider {
  /// Fetch RecordRecordDataProvider
  Future<List<CategoryModel>> fetchCategoryWithServices();
}

/// Implementation of Record RecordDataProvider.
class RecordDataProviderImpl implements RecordDataProvider {
  RecordDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final RestClient restClient;

  @override
  Future<List<CategoryModel>> fetchCategoryWithServices() async {
    final response = await restClient.get('/api/category/with_services');

    final categories = List.from((response['data'] as List))
        .map((e) => CategoryModel.fromJson(e))
        .toList();

    return categories;
  }
}
