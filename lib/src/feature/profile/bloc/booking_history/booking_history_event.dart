import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// BookingHistory events.
@immutable
sealed class BookingHistoryEvent extends _$BookingHistoryEventBase {
  const BookingHistoryEvent();

  /// Factory for fetching BookingHistory.
  const factory BookingHistoryEvent.fetchAll() = BookingHistoryEvent$Fetch;

  /// Factory for cancen booking.
  const factory BookingHistoryEvent.cancelBooking(int bookingId) =
      BookingHistoryEvent$Cancel;
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

/// BookingHistory events base class.
abstract base class _$BookingHistoryEventBase {
  const _$BookingHistoryEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, BookingHistoryEvent$Fetch> fetch,
    required PatternMatch<R, BookingHistoryEvent$Cancel> cancel,
  }) =>
      switch (this) {
        final BookingHistoryEvent$Fetch s => fetch(s),
        final BookingHistoryEvent$Cancel s => cancel(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, BookingHistoryEvent$Fetch>? fetch,
    PatternMatch<R, BookingHistoryEvent$Cancel>? cancel,
  }) =>
      map<R>(
        fetch: fetch ?? (_) => orElse(),
        cancel: cancel ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, BookingHistoryEvent$Fetch>? fetch,
    PatternMatch<R, BookingHistoryEvent$Cancel>? cancel,
  }) =>
      map<R?>(
        fetch: fetch ?? (_) => null,
        cancel: cancel ?? (_) => null,
      );
}
