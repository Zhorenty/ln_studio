import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Timetable events.
@immutable
sealed class TimetableEvent extends _$TimetableEventBase {
  const TimetableEvent();

  /// Factory for fetching Timetable.
  const factory TimetableEvent.fetchEmployeeTimetables(int salonId) =
      TimetableEvent$FetchEmployeeTimetables;
}

/// [TimetableEvent.fetchEmployeeTimetables] event.
final class TimetableEvent$FetchEmployeeTimetables extends TimetableEvent {
  const TimetableEvent$FetchEmployeeTimetables(this.employeeId) : super();

  ///
  final int employeeId;
}

/// Timetable events base class.
abstract base class _$TimetableEventBase {
  const _$TimetableEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, TimetableEvent$FetchEmployeeTimetables>
        fetchEmployeeTimetables,
  }) =>
      switch (this) {
        final TimetableEvent$FetchEmployeeTimetables s =>
          fetchEmployeeTimetables(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, TimetableEvent$FetchEmployeeTimetables>?
        fetchEmployeeTimetables,
  }) =>
      map<R>(
        fetchEmployeeTimetables: fetchEmployeeTimetables ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, TimetableEvent$FetchEmployeeTimetables>?
        fetchEmployeeTimetables,
  }) =>
      map<R?>(
        fetchEmployeeTimetables: fetchEmployeeTimetables ?? (_) => null,
      );
}
