import 'package:flutter/foundation.dart';
import 'package:ln_studio/src/feature/profile/model/booking.dart';

import '/src/common/utils/pattern_match.dart';

/// BookingHistory states.
sealed class BookingHistoryState extends _$BookingHistoryStateBase {
  const BookingHistoryState._({required super.bookingHistory, super.error});

  /// BookingHistory is idle.
  const factory BookingHistoryState.idle({
    List<BookingModel> bookingHistory,
    String? error,
  }) = _BookingHistoryState$Idle;

  /// BookingHistory is loaded.
  const factory BookingHistoryState.loaded({
    required List<BookingModel> bookingHistory,
    String? error,
  }) = _BookingHistoryState$Loaded;
}

/// [BookingHistoryState.idle] state matcher.
final class _BookingHistoryState$Idle extends BookingHistoryState {
  const _BookingHistoryState$Idle({
    super.bookingHistory = const [],
    super.error,
  }) : super._();
}

/// [BookingHistoryState.loaded] state matcher.
final class _BookingHistoryState$Loaded extends BookingHistoryState {
  const _BookingHistoryState$Loaded({
    required super.bookingHistory,
    super.error,
  }) : super._();
}

/// BookingHistory state base class.
@immutable
abstract base class _$BookingHistoryStateBase {
  const _$BookingHistoryStateBase({required this.bookingHistory, this.error});

  @nonVirtual
  final List<BookingModel> bookingHistory;

  @nonVirtual
  final String? error;

  List<BookingModel> get upcomingEvents => bookingHistory.reversed
      .where(
        (e) => !e.isDone && !e.isCanceled,
      )
      .toList();

  List<BookingModel> get pastEvents => bookingHistory.reversed
      .where(
        (e) => e.isDone || e.isCanceled,
      )
      .toList();

  /// Indicator of whether there is an error.
  bool get hasError => error != null;

  /// Indicator whether BookingHistory is not empty.
  bool get hasBookingHistory => bookingHistory.isNotEmpty;

  /// Indicator whether state is already loaded.
  bool get isLoaded => maybeMap(
        loaded: (_) => true,
        orElse: () => false,
      );

  /// Indicator whether state is already idling.
  bool get isIdling => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, _BookingHistoryState$Idle> idle,
    required PatternMatch<R, _BookingHistoryState$Loaded> loaded,
  }) =>
      switch (this) {
        final _BookingHistoryState$Idle idleState => idle(idleState),
        final _BookingHistoryState$Loaded loadedState => loaded(loadedState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _BookingHistoryState$Idle>? idle,
    PatternMatch<R, _BookingHistoryState$Loaded>? loaded,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        loaded: loaded ?? (_) => orElse(),
      );

  @override
  String toString() =>
      'BookingHistoryState(BookingHistory: $bookingHistory, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(bookingHistory, error);
}
