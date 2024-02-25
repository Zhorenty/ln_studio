import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/feature/record/data/record_repository.dart';

import '/src/common/utils/error_util.dart';
import '/src/feature/profile/data/profile_repository.dart';
import 'booking_history_event.dart';
import 'booking_history_state.dart';

/// BookingHistory bloc.
class BookingHistoryBloc
    extends Bloc<BookingHistoryEvent, BookingHistoryState> {
  BookingHistoryBloc({
    required this.repository,
    required this.recordRepository,
  }) : super(const BookingHistoryState.idle()) {
    on<BookingHistoryEvent>(
      (event, emit) => event.map(
        fetch: (event) => _fetchAllBookings(event, emit),
        cancel: (event) => _cancelBooking(event, emit),
        addReview: (event) => _addReview(event, emit),
      ),
    );
  }

  /// Repository for BookingHistory data.
  final ProfileRepository repository;

  /// Repository for BookingHistory data.
  final RecordRepository recordRepository;

  /// Fetch BookingHistory from repository.
  Future<void> _fetchAllBookings(
    BookingHistoryEvent$Fetch event,
    Emitter<BookingHistoryState> emit,
  ) async {
    try {
      final bookingHistory = await repository.getAllBookings();
      emit(BookingHistoryState.loaded(bookingHistory: bookingHistory));
    } on Object catch (e) {
      emit(BookingHistoryState.idle(
        bookingHistory: state.bookingHistory,
        error: ErrorUtil.formatError(e),
      ));
      rethrow;
    }
  }

  /// Cancel booking from repository.
  Future<void> _cancelBooking(
    BookingHistoryEvent$Cancel event,
    Emitter<BookingHistoryState> emit,
  ) async {
    try {
      await recordRepository.cancelRecord(event.bookingId);
      state.bookingHistory[state.bookingHistory.indexWhere(
        (e) => e.id == event.bookingId,
      )] = state.bookingHistory[state.bookingHistory.indexWhere(
        (e) => e.id == event.bookingId,
      )]
          .copyWith(isCanceled: true);

      emit(BookingHistoryState.loaded(bookingHistory: state.bookingHistory));
    } on Object catch (e) {
      emit(BookingHistoryState.idle(
        bookingHistory: state.bookingHistory,
        error: ErrorUtil.formatError(e),
      ));
      rethrow;
    }
  }

  /// Add review from repository.
  Future<void> _addReview(
    BookingHistoryEvent$AddReview event,
    Emitter<BookingHistoryState> emit,
  ) async {
    try {
      await repository.addReview(bookingId: event.bookingId, text: event.text);
      // TODO: Ставить значение isHasReview на true (когда будет приходить)
      // state.bookingHistory[state.bookingHistory.indexWhere(
      //   (e) => e.id == event.bookingId,
      // )] = state.bookingHistory[state.bookingHistory.indexWhere(
      //   (e) => e.id == event.bookingId,
      // )]
      //     .copyWith(isCanceled: true);

      emit(BookingHistoryState.loaded(bookingHistory: state.bookingHistory));
    } on Object catch (e) {
      emit(BookingHistoryState.idle(
        bookingHistory: state.bookingHistory,
        error: ErrorUtil.formatError(e),
      ));
      rethrow;
    }
  }
}
