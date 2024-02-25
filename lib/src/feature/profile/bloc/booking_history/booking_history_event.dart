import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// BookingHistory events.
@immutable
sealed class BookingHistoryEvent extends _$BookingHistoryEventBase {
  const BookingHistoryEvent();

  /// Factory for fetching BookingHistory.
  const factory BookingHistoryEvent.fetchAll() = BookingHistoryEvent$Fetch;

  /// Factory for cancel booking.
  const factory BookingHistoryEvent.cancelBooking(int bookingId) =
      BookingHistoryEvent$Cancel;

  /// Factory for add review.
  const factory BookingHistoryEvent.addReview({
    required int bookingId,
    required String text,
  }) = BookingHistoryEvent$AddReview;
}

/// [BookingHistoryEvent.fetch] event.
final class BookingHistoryEvent$Fetch extends BookingHistoryEvent {
  const BookingHistoryEvent$Fetch() : super();
}

/// [BookingHistoryEvent.cancelBooking] event.
final class BookingHistoryEvent$Cancel extends BookingHistoryEvent {
  const BookingHistoryEvent$Cancel(this.bookingId) : super();

  final int bookingId;
}

/// [BookingHistoryEvent.addReview] event.
final class BookingHistoryEvent$AddReview extends BookingHistoryEvent {
  const BookingHistoryEvent$AddReview({
    required this.bookingId,
    required this.text,
  }) : super();

  final int bookingId;
  final String text;
}

/// BookingHistory events base class.
abstract base class _$BookingHistoryEventBase {
  const _$BookingHistoryEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, BookingHistoryEvent$Fetch> fetch,
    required PatternMatch<R, BookingHistoryEvent$Cancel> cancel,
    required PatternMatch<R, BookingHistoryEvent$AddReview> addReview,
  }) =>
      switch (this) {
        final BookingHistoryEvent$Fetch s => fetch(s),
        final BookingHistoryEvent$Cancel s => cancel(s),
        final BookingHistoryEvent$AddReview s => addReview(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, BookingHistoryEvent$Fetch>? fetch,
    PatternMatch<R, BookingHistoryEvent$Cancel>? cancel,
    PatternMatch<R, BookingHistoryEvent$AddReview>? addReview,
  }) =>
      map<R>(
        fetch: fetch ?? (_) => orElse(),
        cancel: cancel ?? (_) => orElse(),
        addReview: addReview ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, BookingHistoryEvent$Fetch>? fetch,
    PatternMatch<R, BookingHistoryEvent$Cancel>? cancel,
    PatternMatch<R, BookingHistoryEvent$AddReview>? addReview,
  }) =>
      map<R?>(
        fetch: fetch ?? (_) => null,
        cancel: cancel ?? (_) => null,
        addReview: addReview ?? (_) => null,
      );
}
