import '/src/feature/record/data/record_data_provider.dart';
import '/src/feature/record/model/category.dart';

/// Repository for Record data.
abstract interface class RecordRepository {
  /// Get Record.
  Future<List<CategoryModel>> getCategoryWithServices();
}

/// Implementation of the Record repository.
final class RecordRepositoryImpl implements RecordRepository {
  RecordRepositoryImpl(this._dataProvider);

  /// Record data source.
  final RecordDataProvider _dataProvider;

  @override
  Future<List<CategoryModel>> getCategoryWithServices() =>
      _dataProvider.fetchCategoryWithServices();
}
