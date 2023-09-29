import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/record/model/record_create.dart';
import 'package:ln_studio/src/feature/record/model/timetable.dart';
import 'package:rest_client/rest_client.dart';

import '/src/feature/record/model/category.dart';

/// Datasource for Record RecordDataProvider.
abstract interface class RecordDataProvider {
  /// Fetch RecordRecordDataProvider
  Future<List<CategoryModel>> fetchServiceCategories({
    required int salonId,
    int? employeeId,
    int? timeblockId,
    String? dateAt,
  });

  /// Fetch staff by salon id
  Future<List<EmployeeModel>> fetchEmployees({
    required int salonId,
    int? serviceId,
    int? timeblockId,
    String? dateAt,
  });

  ///
  Future<List<TimetableItem>> fetchTimetable({
    required int salonId,
    int? serviceId,
    int? employeeId,
  });

  ///
  Future<List<EmployeeTimeblock$Response>> fetchTimeblocks({
    required int salonId,
    required int timetableItemId,
    int? serviceId,
    int? employeeId,
  });

  Future<void> createRecord(RecordModel$Create recordData);
}

/// Implementation of Record RecordDataProvider.
class RecordDataProviderImpl implements RecordDataProvider {
  RecordDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final RestClient restClient;

  @override
  Future<List<CategoryModel>> fetchServiceCategories({
    required int salonId,
    int? employeeId,
    int? timeblockId,
    String? dateAt,
  }) async {
    final response = await restClient.get(
      '/api/category/with_services',
      queryParams: {
        'salon_id': salonId,
        if (employeeId != null) 'employee_id': employeeId,
        if (timeblockId != null) 'timeblock_id': timeblockId,
        if (dateAt != null) 'date_at': dateAt,
      },
    );

    final categories = List.from((response['data'] as List))
        .map((e) => CategoryModel.fromJson(e))
        .toList();

    return categories;
  }

  @override
  Future<List<EmployeeModel>> fetchEmployees({
    required int salonId,
    int? serviceId,
    int? timeblockId,
    String? dateAt,
  }) async {
    final response = await restClient.get(
      '/api/employee/by_salon_id/$salonId',
      queryParams: {
        'salon_id': salonId,
        if (timeblockId != null) 'timeblock_id': timeblockId,
        if (dateAt != null) 'date_at': dateAt,
      },
    );

    final staff = List.from((response['data'] as List))
        .map((e) => EmployeeModel.fromJson(e))
        .toList();

    return staff;
  }

  @override
  Future<List<TimetableItem>> fetchTimetable({
    required int salonId,
    int? serviceId,
    int? employeeId,
  }) async {
    final response = await restClient.get(
      '/api/timetable/by_employee_id/$employeeId',
      queryParams: {
        'salon_id': salonId,
        if (serviceId != null) 'service_id': serviceId,
        if (employeeId != null) 'employee_id': employeeId,
      },
    );

    final timetables = List.from((response['data'] as List))
        .map((e) => TimetableItem.fromJson(e))
        .toList();

    return timetables;
  }

  @override
  Future<List<EmployeeTimeblock$Response>> fetchTimeblocks({
    required int salonId,
    required int timetableItemId,
    int? serviceId,
    int? employeeId,
  }) async {
    final response = await restClient.post(
      '/api/timeblock/refresh',
      body: {
        'salon_id': salonId,
        'timetable_item_id': timetableItemId,
        if (serviceId != null) 'service_id': serviceId,
        if (employeeId != null) 'employee_id': employeeId,
      },
    );

    final timeblocks = List.from((response['data'] as List))
        .map((e) => EmployeeTimeblock$Response.fromJson(e))
        .toList();

    return timeblocks;
  }

  @override
  Future<void> createRecord(RecordModel$Create recordData) async {
    final body = recordData.toJson();
    await restClient.post(
      '/api/service_sale/book_service',
      body: body,
    );
  }
}
