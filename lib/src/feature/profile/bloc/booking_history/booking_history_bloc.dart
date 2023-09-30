import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/utils/error_util.dart';
import '/src/feature/profile/data/profile_repository.dart';
import 'booking_history_event.dart';
import 'booking_history_state.dart';

/// BookingHistory bloc.
class BookingHistoryBloc
    extends Bloc<BookingHistoryEvent, BookingHistoryState> {
  BookingHistoryBloc({required this.repository})
      : super(const BookingHistoryState.idle()) {
    on<BookingHistoryEvent>(
      (event, emit) => event.map(
        fetch: (event) => _fetchAllEmployees(event, emit),
      ),
    );
  }

  /// Repository for BookingHistory data.
  final ProfileRepository repository;

  /// Fetch BookingHistory from repository.
  Future<void> _fetchAllEmployees(
    BookingHistoryEvent$Fetch event,
    Emitter<BookingHistoryState> emit,
  ) async {
    try {
      final bookingHistory = await repository.getAllBookings();
      emit(BookingHistoryState.loaded(bookingHistory: bookingHistory));
    } on Object catch (e) {
      emit(
        BookingHistoryState.idle(
          bookingHistory: state.bookingHistory,
          error: ErrorUtil.formatError(e),
        ),
      );
      rethrow;
    }
  }
}
