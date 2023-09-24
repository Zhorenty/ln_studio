import 'package:ln_studio/src/common/utils/extensions/date_time_extension.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/record/model/timetable.dart';
import 'package:rest_client/rest_client.dart';

import '/src/feature/record/model/category.dart';

/// Datasource for Record RecordDataProvider.
abstract interface class RecordDataProvider {
  /// Fetch RecordRecordDataProvider
  Future<List<CategoryModel>> fetchCategories();

  /// Fetch staff by salon id
  Future<List<EmployeeModel>> fetchSalonEmployees(int salonId);

  ///
  Future<List<EmployeeTimetable>> fetchEmployeeTimetable(int employeeId);

  ///
  Future<List<EmployeeTimeblock>> fetchEmployeeTimeblocks(
    EmployeeTimeblock timeblock,
  );
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

  @override
  Future<List<EmployeeTimetable>> fetchEmployeeTimetable(int employeeId) async {
    final response = await restClient.get(
      '/api/timetable/by_employee_id/$employeeId',
    );

    final timetables = List.from((response['data'] as List))
        .map((e) => EmployeeTimetable.fromJson(e))
        .toList();

    return timetables;
  }

  @override
  Future<List<EmployeeTimeblock>> fetchEmployeeTimeblocks(
    EmployeeTimeblock timeblock,
  ) async {
    final response = await restClient.post(
      '/api/timeblock/refresh',
      body: {
        'date_at': timeblock.dateAt.jsonFormat(),
        'employee_id': timeblock.employeeId,
        'salon_id': timeblock.salonId,
      },
    );

    final timeblocks = List.from((response['data'] as List))
        .map((e) => EmployeeTimeblock.fromJson(e))
        .toList();

    return timeblocks;
  }
}
