import 'package:flutter/foundation.dart';
import 'package:ln_studio/src/feature/record/model/timetable.dart';

import '/src/common/utils/pattern_match.dart';

/// Timeblock events.
@immutable
sealed class TimeblockEvent extends _$TimeblockEventBase {
  const TimeblockEvent();

  /// Factory for fetching Timeblock.
  const factory TimeblockEvent.fetchEmployeeTimeblocks(
    EmployeeTimeblock$Body timeblock,
  ) = TimeblockEvent$FetchEmployeeTimeblocks;
}

/// [TimeblockEvent.fetchEmployeeTimeblocks] event.
final class TimeblockEvent$FetchEmployeeTimeblocks extends TimeblockEvent {
  const TimeblockEvent$FetchEmployeeTimeblocks(this.timeblock) : super();

  ///
  final EmployeeTimeblock$Body timeblock;
}

/// Timeblock events base class.
abstract base class _$TimeblockEventBase {
  const _$TimeblockEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, TimeblockEvent$FetchEmployeeTimeblocks>
        fetchEmployeeTimeblocks,
  }) =>
      switch (this) {
        final TimeblockEvent$FetchEmployeeTimeblocks s =>
          fetchEmployeeTimeblocks(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, TimeblockEvent$FetchEmployeeTimeblocks>?
        fetchEmployeeTimeblocks,
  }) =>
      map<R>(
        fetchEmployeeTimeblocks: fetchEmployeeTimeblocks ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, TimeblockEvent$FetchEmployeeTimeblocks>?
        fetchEmployeeTimeblocks,
  }) =>
      map<R?>(
        fetchEmployeeTimeblocks: fetchEmployeeTimeblocks ?? (_) => null,
      );
}
