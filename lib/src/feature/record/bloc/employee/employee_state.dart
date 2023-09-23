import 'package:flutter/foundation.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';

import '/src/common/utils/pattern_match.dart';

/// Employee states.
sealed class EmployeeState extends _$EmployeeStateBase {
  const EmployeeState._({required super.employees, super.error});

  /// Employee is idle.
  const factory EmployeeState.idle({
    List<EmployeeModel> employees,
    String? error,
  }) = _EmployeeState$Idle;

  /// Employee is loaded.
  const factory EmployeeState.loaded({
    required List<EmployeeModel> employees,
    String? error,
  }) = _EmployeeState$Loaded;
}

/// [EmployeeState.idle] state matcher.
final class _EmployeeState$Idle extends EmployeeState {
  const _EmployeeState$Idle({
    super.employees = const [],
    super.error,
  }) : super._();
}

/// [EmployeeState.loaded] state matcher.
final class _EmployeeState$Loaded extends EmployeeState {
  const _EmployeeState$Loaded({
    required super.employees,
    super.error,
  }) : super._();
}

/// Employee state base class.
@immutable
abstract base class _$EmployeeStateBase {
  const _$EmployeeStateBase({required this.employees, this.error});

  @nonVirtual
  final List<EmployeeModel> employees;

  @nonVirtual
  final String? error;

  /// Indicator of whether there is an error.
  bool get hasError => error != null;

  /// Indicator whether Employee is not empty.
  bool get hasEmployee => employees.isNotEmpty;

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
    required PatternMatch<R, _EmployeeState$Idle> idle,
    required PatternMatch<R, _EmployeeState$Loaded> loaded,
  }) =>
      switch (this) {
        final _EmployeeState$Idle idleState => idle(idleState),
        final _EmployeeState$Loaded loadedState => loaded(loadedState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _EmployeeState$Idle>? idle,
    PatternMatch<R, _EmployeeState$Loaded>? loaded,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        loaded: loaded ?? (_) => orElse(),
      );

  @override
  String toString() => 'EmployeeState(Employees: $employees, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(employees, error);
}
