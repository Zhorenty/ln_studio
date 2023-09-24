import 'package:flutter/foundation.dart';
import 'package:ln_studio/src/feature/record/model/timetable.dart';

import '/src/common/utils/pattern_match.dart';

/// Timeblock states.
sealed class TimeblockState extends _$TimeblockStateBase {
  const TimeblockState._({required super.timeblocks, super.error});

  /// Timeblock is idle.
  const factory TimeblockState.idle({
    List<EmployeeTimeblock> timeblocks,
    String? error,
  }) = _TimeblockState$Idle;

  /// Timeblock is loaded.
  const factory TimeblockState.loaded({
    required List<EmployeeTimeblock> timeblocks,
    String? error,
  }) = _TimeblockState$Loaded;
}

/// [TimeblockState.idle] state matcher.
final class _TimeblockState$Idle extends TimeblockState {
  const _TimeblockState$Idle({
    super.timeblocks = const [],
    super.error,
  }) : super._();
}

/// [TimeblockState.loaded] state matcher.
final class _TimeblockState$Loaded extends TimeblockState {
  const _TimeblockState$Loaded({
    required super.timeblocks,
    super.error,
  }) : super._();
}

/// Timeblock state base class.
@immutable
abstract base class _$TimeblockStateBase {
  const _$TimeblockStateBase({required this.timeblocks, this.error});

  @nonVirtual
  final List<EmployeeTimeblock> timeblocks;

  @nonVirtual
  final String? error;

  /// Indicator of whether there is an error.
  bool get hasError => error != null;

  /// Indicator whether Timeblock is not empty.
  bool get hasTimeblock => timeblocks.isNotEmpty;

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
    required PatternMatch<R, _TimeblockState$Idle> idle,
    required PatternMatch<R, _TimeblockState$Loaded> loaded,
  }) =>
      switch (this) {
        final _TimeblockState$Idle idleState => idle(idleState),
        final _TimeblockState$Loaded loadedState => loaded(loadedState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _TimeblockState$Idle>? idle,
    PatternMatch<R, _TimeblockState$Loaded>? loaded,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        loaded: loaded ?? (_) => orElse(),
      );

  @override
  String toString() => 'TimeblockState(Timeblocks: $timeblocks, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(timeblocks, error);
}
