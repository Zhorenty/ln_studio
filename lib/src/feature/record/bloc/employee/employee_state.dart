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
  const factory EmployeeState.processing({
    required List<EmployeeModel> employees,
    String? error,
  }) = _EmployeeState$Processing;
}

/// [EmployeeState.idle] state matcher.
final class _EmployeeState$Idle extends EmployeeState {
  const _EmployeeState$Idle({
    super.employees = const [],
    super.error,
  }) : super._();
}

/// [EmployeeState.processing] state matcher.
final class _EmployeeState$Processing extends EmployeeState {
  const _EmployeeState$Processing({
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
  bool get isProcessing => maybeMap(
        isProcessing: (_) => true,
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
    required PatternMatch<R, _EmployeeState$Processing> isProcessing,
  }) =>
      switch (this) {
        final _EmployeeState$Idle idleState => idle(idleState),
        final _EmployeeState$Processing processingState =>
          isProcessing(processingState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _EmployeeState$Idle>? idle,
    PatternMatch<R, _EmployeeState$Processing>? isProcessing,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        isProcessing: isProcessing ?? (_) => orElse(),
      );

  @override
  String toString() => 'EmployeeState(Employees: $employees, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(employees, error);
}
