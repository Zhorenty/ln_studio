import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/feature/record/data/record_repository.dart';

import '/src/common/utils/error_util.dart';

import 'timeblock_state.dart';
import 'timeblock_event.dart';

/// Timeblock bloc.
class TimeblockBloc extends Bloc<TimeblockEvent, TimeblockState> {
  TimeblockBloc({required this.repository})
      : super(const TimeblockState.idle()) {
    on<TimeblockEvent>(
      (event, emit) => event.map(
        fetchEmployeeTimeblocks: (event) =>
            _fetchEmployeeTimeblocks(event, emit),
      ),
    );
  }

  /// Repository for Timeblock data.
  final RecordRepository repository;

  /// Fetch Timeblock from repository.
  Future<void> _fetchEmployeeTimeblocks(
    TimeblockEvent$FetchEmployeeTimeblocks event,
    Emitter<TimeblockState> emit,
  ) async {
    try {
      final timeblocks = await repository.getEmployeeTimeblocks(
        event.timeblock,
      );
      emit(TimeblockState.loaded(timeblocks: timeblocks));
    } on Object catch (e) {
      emit(
        TimeblockState.idle(
          timeblocks: state.timeblocks,
          error: ErrorUtil.formatError(e),
        ),
      );
      rethrow;
    }
  }
}
