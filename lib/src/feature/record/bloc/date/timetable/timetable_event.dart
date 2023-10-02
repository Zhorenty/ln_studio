import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Timetable events.
@immutable
sealed class TimetableEvent extends _$TimetableEventBase {
  const TimetableEvent();

  /// Factory for fetching Timetable.
  const factory TimetableEvent.fetchTimetables({
    required int salonId,
    required int? serviceId,
    required int? employeeId,
  }) = TimetableEvent$FetchTimetables;
}

/// [TimetableEvent.fetchTimetables] event.
final class TimetableEvent$FetchTimetables extends TimetableEvent {
  const TimetableEvent$FetchTimetables({
    required this.salonId,
    required this.serviceId,
    required this.employeeId,
  });

  final int salonId;
  final int? serviceId;
  final int? employeeId;
}

/// Timetable events base class.
abstract base class _$TimetableEventBase {
  const _$TimetableEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, TimetableEvent$FetchTimetables> fetchTimetables,
  }) =>
      switch (this) {
        final TimetableEvent$FetchTimetables s => fetchTimetables(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, TimetableEvent$FetchTimetables>? fetchTimetables,
  }) =>
      map<R>(
        fetchTimetables: fetchTimetables ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, TimetableEvent$FetchTimetables>? fetchTimetables,
  }) =>
      map<R?>(
        fetchTimetables: fetchTimetables ?? (_) => null,
      );
}
