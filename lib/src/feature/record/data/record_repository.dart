import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/record/model/record_create.dart';
import 'package:ln_studio/src/feature/record/model/timetable.dart';

import '/src/feature/record/data/record_data_provider.dart';
import '/src/feature/record/model/category.dart';

/// Repository for Record data.
abstract interface class RecordRepository {
  /// Get RecordRecordDataProvider
  Future<List<CategoryModel>> getServiceCategories({
    required int salonId,
    int? employeeId,
    int? timeblockId,
    String? dateAt,
  });

  /// Get staff by salon id
  Future<List<EmployeeModel>> getEmployees({
    required int salonId,
    int? serviceId,
    int? timeblockId,
    String? dateAt,
  });

  ///
  Future<List<TimetableItem>> getTimetable({
    required int salonId,
    int? serviceId,
    int? employeeId,
  });

  ///
  Future<List<EmployeeTimeblock$Response>> getTimeblocks({
    required int salonId,
    required String dateAt,
    int? serviceId,
    int? employeeId,
  });

  Future<void> createRecord(RecordModel$Create recordData);
}

/// Implementation of the Record repository.
final class RecordRepositoryImpl implements RecordRepository {
  RecordRepositoryImpl(this._dataProvider);

  /// Record data source.
  final RecordDataProvider _dataProvider;

  @override
  Future<List<CategoryModel>> getServiceCategories({
    required int salonId,
    int? employeeId,
    int? timeblockId,
    String? dateAt,
  }) =>
      _dataProvider.fetchServiceCategories(
        salonId: salonId,
        employeeId: employeeId,
        timeblockId: timeblockId,
        dateAt: dateAt,
      );

  @override
  Future<List<EmployeeModel>> getEmployees({
    required int salonId,
    int? serviceId,
    int? timeblockId,
    String? dateAt,
  }) =>
      _dataProvider.fetchEmployees(
        salonId: salonId,
        serviceId: serviceId,
        timeblockId: timeblockId,
        dateAt: dateAt,
      );

  @override
  Future<List<TimetableItem>> getTimetable({
    required int salonId,
    int? serviceId,
    int? employeeId,
  }) =>
      _dataProvider.fetchTimetable(
        salonId: salonId,
        serviceId: serviceId,
        employeeId: employeeId,
      );

  @override
  Future<List<EmployeeTimeblock$Response>> getTimeblocks({
    required int salonId,
    required String dateAt,
    int? serviceId,
    int? employeeId,
  }) =>
      _dataProvider.fetchTimeblocks(
        salonId: salonId,
        dateAt: dateAt,
        serviceId: serviceId,
        employeeId: employeeId,
      );

  @override
  Future<void> createRecord(RecordModel$Create recordData) =>
      _dataProvider.createRecord(recordData);
}
