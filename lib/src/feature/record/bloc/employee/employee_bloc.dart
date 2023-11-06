import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/feature/record/data/record_repository.dart';

import '/src/common/utils/error_util.dart';

import 'employee_event.dart';
import 'employee_state.dart';

/// Employee bloc.
class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({required this.repository}) : super(const EmployeeState.idle()) {
    on<EmployeeEvent>(
      (event, emit) => event.map(
        fetchEmployees: (event) => _fetchEmployees(event, emit),
      ),
    );
  }

  /// Repository for Employee data.
  final RecordRepository repository;

  /// Fetch Employee from repository.
  Future<void> _fetchEmployees(
    EmployeeEvent$FetchEmployees event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(EmployeeState.processing(employees: state.employees));
      final employees = await repository.getEmployees(
        salonId: event.salonId,
        serviceId: event.serviceId,
        timeblockId: event.timeblockId,
        dateAt: event.dateAt,
      );
      emit(EmployeeState.successful(employees: employees));
    } on Object catch (e) {
      emit(
        EmployeeState.idle(
          employees: state.employees,
          error: ErrorUtil.formatError(e),
        ),
      );
      rethrow;
    }
  }
}
