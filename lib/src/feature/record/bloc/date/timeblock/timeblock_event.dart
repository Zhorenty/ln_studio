import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Timeblock events.
@immutable
sealed class TimeblockEvent extends _$TimeblockEventBase {
  const TimeblockEvent();

  /// Factory for fetching Timeblock.
  const factory TimeblockEvent.fetchTimeblocks({
    required int salonId,
    required int timetableItemId,
    required int? serviceId,
    required int? employeeId,
  }) = TimeblockEvent$FetchTimeblocks;
}

/// [TimeblockEvent.fetchTimeblocks] event.
final class TimeblockEvent$FetchTimeblocks extends TimeblockEvent {
  const TimeblockEvent$FetchTimeblocks({
    required this.salonId,
    required this.timetableItemId,
    required this.serviceId,
    required this.employeeId,
  });

  ///
  final int salonId;
  final int timetableItemId;
  final int? serviceId;
  final int? employeeId;
}

/// Timeblock events base class.
abstract base class _$TimeblockEventBase {
  const _$TimeblockEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, TimeblockEvent$FetchTimeblocks> fetchTimeblocks,
  }) =>
      switch (this) {
        final TimeblockEvent$FetchTimeblocks s => fetchTimeblocks(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, TimeblockEvent$FetchTimeblocks>? fetchTimeblocks,
  }) =>
      map<R>(
        fetchTimeblocks: fetchTimeblocks ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, TimeblockEvent$FetchTimeblocks>? fetchTimeblocks,
  }) =>
      map<R?>(
        fetchTimeblocks: fetchTimeblocks ?? (_) => null,
      );
}
