import 'package:dio/dio.dart';
import 'package:ln_studio/src/feature/profile/model/booking.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/record/model/record_create.dart';
import 'package:ln_studio/src/feature/record/model/timetable.dart';

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
    required String dateAt,
    int? serviceId,
    int? employeeId,
  });

  Future<void> createRecord(RecordModel$Create recordData);

  Future<BookingModel> fetchLastBooking();
}

/// Implementation of Record RecordDataProvider.
class RecordDataProviderImpl implements RecordDataProvider {
  RecordDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final Dio restClient;

  @override
  Future<List<CategoryModel>> fetchServiceCategories({
    required int salonId,
    int? employeeId,
    int? timeblockId,
    String? dateAt,
  }) async {
    final params = {
      'salon_id': salonId,
      if (employeeId != null) 'employee_id': employeeId,
      if (timeblockId != null) 'timeblock_id': timeblockId,
      if (dateAt != null) 'date_at': dateAt,
    };
    final response = await restClient.get(
      '/api/v1/book/get_services',
      queryParameters: params,
    );

    final categories = List.from((response.data['data'] as List))
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
      '/api/v1/book/get_employees',
      queryParameters: {
        'salon_id': salonId,
        if (serviceId != null) 'service_id': serviceId,
        if (timeblockId != null) 'timeblock_id': timeblockId,
        if (dateAt != null) 'date_at': dateAt,
      },
    );

    final staff = List.from((response.data['data'] as List))
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
      '/api/v1/book/get_timetables',
      queryParameters: {
        'salon_id': salonId,
        if (serviceId != null) 'service_id': serviceId,
        if (employeeId != null) 'employee_id': employeeId,
      },
    );

    final timetables = List.from((response.data['data'] as List))
        .map((e) => TimetableItem.fromJson(e))
        .toList();

    return timetables;
  }

  @override
  Future<List<EmployeeTimeblock$Response>> fetchTimeblocks({
    required int salonId,
    required String dateAt,
    int? serviceId,
    int? employeeId,
  }) async {
    final response = await restClient.get(
      '/api/v1/book/get_timeblocks',
      queryParameters: {
        'salon_id': salonId,
        'date_at': dateAt,
        if (serviceId != null) 'service_id': serviceId,
        if (employeeId != null) 'employee_id': employeeId,
      },
    );

    final timeblocks = List.from((response.data['data'] as List))
        .map((e) => EmployeeTimeblock$Response.fromJson(e))
        .toList();

    return timeblocks;
  }

  @override
  Future<void> createRecord(RecordModel$Create recordData) async {
    final body = recordData.toJson();
    await restClient.post(
      '/api/v1/service_sale/book_service',
      data: body,
    );
  }

  @override
  Future<BookingModel> fetchLastBooking() async {
    final response = await restClient.get('/api/v1/book/get_reentry');
    final lastBooking = BookingModel.fromJson(response.data['data']);
    return lastBooking;
  }
}
