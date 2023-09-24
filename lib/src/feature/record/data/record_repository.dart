import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/record/model/timetable.dart';

import '/src/feature/record/data/record_data_provider.dart';
import '/src/feature/record/model/category.dart';

/// Repository for Record data.
abstract interface class RecordRepository {
  /// Get Record.
  Future<List<CategoryModel>> getCategories();

  /// Fetch staff by salon id
  Future<List<EmployeeModel>> getSalonEmployees(int salonId);

  ///
  Future<List<EmployeeTimetable>> getEmployeeTimetable(int employeeId);

  ///
  Future<List<EmployeeTimeblock>> getEmployeeTimeblocks(
    EmployeeTimeblock timeblock,
  );
}

/// Implementation of the Record repository.
final class RecordRepositoryImpl implements RecordRepository {
  RecordRepositoryImpl(this._dataProvider);

  /// Record data source.
  final RecordDataProvider _dataProvider;

  @override
  Future<List<CategoryModel>> getCategories() =>
      _dataProvider.fetchCategories();

  @override
  Future<List<EmployeeModel>> getSalonEmployees(int salonId) =>
      _dataProvider.fetchSalonEmployees(salonId);

  @override
  Future<List<EmployeeTimetable>> getEmployeeTimetable(int employeeId) =>
      _dataProvider.fetchEmployeeTimetable(employeeId);

  @override
  Future<List<EmployeeTimeblock>> getEmployeeTimeblocks(
    EmployeeTimeblock timeblock,
  ) =>
      _dataProvider.fetchEmployeeTimeblocks(timeblock);
}
