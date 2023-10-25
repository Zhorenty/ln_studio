import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Employee events.
@immutable
sealed class EmployeeEvent extends _$EmployeeEventBase {
  const EmployeeEvent();

  /// Factory for fetching employee by id.
  const factory EmployeeEvent.fetch({required int id}) = EmployeeEvent$Fetch;

  /// Factory for fetching Employee.
  const factory EmployeeEvent.fetchEmployees({
    required int salonId,
    required int? serviceId,
    required int? timeblockId,
    required String? dateAt,
  }) = EmployeeEvent$FetchEmployees;
}

/// [EmployeeEvent.fetch] event.
final class EmployeeEvent$Fetch extends EmployeeEvent {
  const EmployeeEvent$Fetch({required this.id});

  /// Employee's id.
  final int id;
}

/// [EmployeeEvent.fetchEmployees] event.
final class EmployeeEvent$FetchEmployees extends EmployeeEvent {
  const EmployeeEvent$FetchEmployees({
    required this.salonId,
    required this.serviceId,
    required this.timeblockId,
    required this.dateAt,
  });

  ///
  final int salonId;
  final int? serviceId;
  final int? timeblockId;
  final String? dateAt;
}

/// Employee events base class.
abstract base class _$EmployeeEventBase {
  const _$EmployeeEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, EmployeeEvent$FetchEmployees> fetchEmployees,
  }) =>
      switch (this) {
        final EmployeeEvent$FetchEmployees s => fetchEmployees(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, EmployeeEvent$FetchEmployees>? fetchEmployees,
  }) =>
      map<R>(
        fetchEmployees: fetchEmployees ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, EmployeeEvent$FetchEmployees>? fetchEmployees,
  }) =>
      map<R?>(
        fetchEmployees: fetchEmployees ?? (_) => null,
      );
}
