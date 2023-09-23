import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:rest_client/rest_client.dart';

import '/src/feature/record/model/category.dart';

/// Datasource for Record RecordDataProvider.
abstract interface class RecordDataProvider {
  /// Fetch RecordRecordDataProvider
  Future<List<CategoryModel>> fetchCategories();

  /// Fetch staff by salon id
  Future<List<EmployeeModel>> fetchSalonEmployees(int salonId);
}

/// Implementation of Record RecordDataProvider.
class RecordDataProviderImpl implements RecordDataProvider {
  RecordDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final RestClient restClient;

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await restClient.get('/api/category/with_services');

    final categories = List.from((response['data'] as List))
        .map((e) => CategoryModel.fromJson(e))
        .toList();

    return categories;
  }

  @override
  Future<List<EmployeeModel>> fetchSalonEmployees(int salonId) async {
    final response = await restClient.get('/api/employee/by_salon_id/$salonId');

    final staff = List.from((response['data'] as List))
        .map((e) => EmployeeModel.fromJson(e))
        .toList();

    return staff;
  }
}
