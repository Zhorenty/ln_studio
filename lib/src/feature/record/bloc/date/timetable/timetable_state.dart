import 'package:flutter/foundation.dart';
import 'package:ln_studio/src/feature/record/model/timetable.dart';

import '/src/common/utils/pattern_match.dart';

/// Timetable states.
sealed class TimetableState extends _$TimetableStateBase {
  const TimetableState._({required super.timetables, super.error});

  /// Timetable is idle.
  const factory TimetableState.idle({
    List<EmployeeTimetable> timetables,
    String? error,
  }) = _TimetableState$Idle;

  /// Timetable is loaded.
  const factory TimetableState.loaded({
    required List<EmployeeTimetable> timetables,
    String? error,
  }) = _TimetableState$Loaded;
}

/// [TimetableState.idle] state matcher.
final class _TimetableState$Idle extends TimetableState {
  const _TimetableState$Idle({
    super.timetables = const [],
    super.error,
  }) : super._();
}

/// [TimetableState.loaded] state matcher.
final class _TimetableState$Loaded extends TimetableState {
  const _TimetableState$Loaded({
    required super.timetables,
    super.error,
  }) : super._();
}

/// Timetable state base class.
@immutable
abstract base class _$TimetableStateBase {
  const _$TimetableStateBase({required this.timetables, this.error});

  @nonVirtual
  final List<EmployeeTimetable> timetables;

  @nonVirtual
  final String? error;

  /// Indicator of whether there is an error.
  bool get hasError => error != null;

  /// Indicator whether Timetable is not empty.
  bool get hasTimetable => timetables.isNotEmpty;

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
    required PatternMatch<R, _TimetableState$Idle> idle,
    required PatternMatch<R, _TimetableState$Loaded> loaded,
  }) =>
      switch (this) {
        final _TimetableState$Idle idleState => idle(idleState),
        final _TimetableState$Loaded loadedState => loaded(loadedState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _TimetableState$Idle>? idle,
    PatternMatch<R, _TimetableState$Loaded>? loaded,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        loaded: loaded ?? (_) => orElse(),
      );

  @override
  String toString() => 'TimetableState(Timetables: $timetables, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(timetables, error);
}
