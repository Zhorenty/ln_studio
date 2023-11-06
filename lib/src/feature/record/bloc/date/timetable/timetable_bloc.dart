import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/feature/record/data/record_repository.dart';

import '/src/common/utils/error_util.dart';

import 'timetable_event.dart';
import 'timetable_state.dart';

/// Timetable bloc.
class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  TimetableBloc({required this.repository})
      : super(const TimetableState.idle()) {
    on<TimetableEvent>(
      (event, emit) => event.map(
        fetchTimetables: (event) => _fetchTimetables(event, emit),
      ),
    );
  }

  /// Repository for Timetable data.
  final RecordRepository repository;

  /// Fetch Timetable from repository.
  Future<void> _fetchTimetables(
    TimetableEvent$FetchTimetables event,
    Emitter<TimetableState> emit,
  ) async {
    try {
      emit(TimetableState.processing(timetables: state.timetables));
      final timetables = await repository.getTimetable(
        salonId: event.salonId,
        serviceId: event.serviceId,
        employeeId: event.employeeId,
      );
      emit(TimetableState.successful(timetables: timetables));
    } on Object catch (e) {
      emit(
        TimetableState.idle(
          timetables: state.timetables,
          error: ErrorUtil.formatError(e),
        ),
      );
      rethrow;
    }
  }
}
