import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '/src/feature/salon/data/salon_repository.dart';
import 'salon_event.dart';
import 'salon_state.dart';

/// Business Logic Component SalonBLoC
class SalonBLoC extends Bloc<SalonEvent, SalonState> {
  SalonBLoC({
    required final SalonRepository repository,
    final SalonState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const SalonState.idle(
                data: null,
                currentSalon: null,
                message: 'Initial idle state',
              ),
        ) {
    on<SalonEvent>(
      (event, emit) => switch (event) {
        SalonEvent$FetchAll() => _fetchAll(emit),
        SalonEvent$GetCurrent() => _getCurrent(emit),
        SalonEvent$SaveCurrent() => _saveCurrent(event, emit),
      },
    );
  }

  ///
  final SalonRepository _repository;

  /// Fetch event handler
  Future<void> _fetchAll(Emitter<SalonState> emit) async {
    try {
      emit(
        SalonState.processing(
          data: state.data,
          currentSalon: state.currentSalon,
        ),
      );
      final salons = await _repository.fetchSalons();

      emit(SalonState.successful(
        data: salons,
        currentSalon: state.currentSalon,
      ));
    } on Object catch (err, _) {
      emit(
        SalonState.error(data: state.data, currentSalon: state.currentSalon),
      );
      rethrow;
    } finally {
      emit(
        SalonState.idle(data: state.data, currentSalon: state.currentSalon),
      );
    }
  }

  /// Returns current salon from repository.
  Future<void> _getCurrent(Emitter<SalonState> emit) async {
    try {
      emit(
        SalonState.processing(
          data: state.data,
          currentSalon: state.currentSalon,
        ),
      );
      final salons = await _repository.fetchSalons();
      final currentSalonIdFromDB = await _repository.getCurrentSalonId();

      final currentSalon = salons.firstWhereOrNull(
        (salon) => salon.id == currentSalonIdFromDB,
      );

      emit(SalonState.successful(data: salons, currentSalon: currentSalon));
    } on Object catch (err, _) {
      emit(
        SalonState.error(data: state.data, currentSalon: state.currentSalon),
      );
      rethrow;
    } finally {
      emit(
        SalonState.idle(data: state.data, currentSalon: state.currentSalon),
      );
    }
  }

  /// Save current salon event handler
  Future<void> _saveCurrent(
      SalonEvent$SaveCurrent event, Emitter<SalonState> emit) async {
    try {
      emit(
        SalonState.processing(
          data: state.data,
          currentSalon: state.currentSalon,
        ),
      );
      await _repository.saveCurrentSalonId(event.salon.id);
      emit(SalonState.successful(data: state.data, currentSalon: event.salon));
    } on Object catch (err, _) {
      emit(
        SalonState.error(data: state.data, currentSalon: state.currentSalon),
      );
      rethrow;
    } finally {
      emit(
        SalonState.idle(data: state.data, currentSalon: state.currentSalon),
      );
    }
  }
}
