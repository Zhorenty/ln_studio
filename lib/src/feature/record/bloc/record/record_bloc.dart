import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/feature/record/data/record_repository.dart';
import 'package:ln_studio/src/feature/record/model/record_create.dart';

import 'record_event.dart';
import 'record_state.dart';

/// Business Logic Component RecordBLoC
class RecordBLoC extends Bloc<RecordEvent, RecordState>
    implements EventSink<RecordEvent> {
  RecordBLoC({
    required this.repository,
    final RecordState? initialState,
  }) : super(
          initialState ??
              const RecordState.idle(
                service: null,
                employee: null,
                date: null,
                salon: null,
                timetableItem: null,
                comment: null,
                message: 'Initial idle state',
              ),
        ) {
    on<RecordEvent>(
      (event, emit) => switch (event) {
        RecordEvent$Create() => _create(event, emit),
      },
    );
  }

  /// Repository for Employee data.
  final RecordRepository repository;

  /// Fetch event handler
  Future<void> _create(
      RecordEvent$Create event, Emitter<RecordState> emit) async {
    try {
      emit(RecordState.processing(
        service: state.service,
        employee: state.employee,
        date: state.date,
        salon: state.salon,
        timetableItem: state.timetableItem,
        comment: state.comment,
      ));
      await repository.createRecord(
        RecordModel$Create(
          date: event.dateAt,
          serviceId: event.serviceId,
          employeeId: event.employeeId,
          salonId: event.salonId,
          clientId: event.clientId,
          timeblockId: event.timeblockId,
        ),
      );
      emit(RecordState.successful(
        service: state.service,
        employee: state.employee,
        date: state.date,
        salon: state.salon,
        timetableItem: state.timetableItem,
        comment: state.comment,
      ));
    } on Object catch (err, _) {
      emit(RecordState.error(
        service: state.service,
        employee: state.employee,
        date: state.date,
        salon: state.salon,
        timetableItem: state.timetableItem,
        comment: state.comment,
      ));
      rethrow;
    }
  }
}
