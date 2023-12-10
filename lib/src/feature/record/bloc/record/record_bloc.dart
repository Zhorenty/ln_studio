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
                lastBooking: null,
                message: 'Initial idle state',
              ),
        ) {
    on<RecordEvent>(
      (event, emit) => switch (event) {
        RecordEvent$Create() => _create(event, emit),
        RecordEvent$FetchLastBooking() => _fetchLastBooking(emit),
      },
    );
  }

  /// Repository for Employee data.
  final RecordRepository repository;

  /// Create event handler
  Future<void> _create(
    RecordEvent$Create event,
    Emitter<RecordState> emit,
  ) async {
    try {
      emit(RecordState.processing(lastBooking: state.lastBooking));
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
      emit(RecordState.successful(lastBooking: state.lastBooking));
    } on Object catch (err, _) {
      emit(RecordState.error(lastBooking: state.lastBooking));
      rethrow;
    }
  }

  /// Fetch event handler
  Future<void> _fetchLastBooking(Emitter<RecordState> emit) async {
    try {
      emit(RecordState.processing(lastBooking: state.lastBooking));
      final lastBooking = await repository.fetchLastBooking();
      emit(RecordState.idle(lastBooking: lastBooking));
    } on Object catch (err, _) {
      emit(RecordState.error(lastBooking: state.lastBooking));
      rethrow;
    }
  }
}
