import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Employee events.
@immutable
sealed class EmployeeEvent extends _$EmployeeEventBase {
  const EmployeeEvent();

  /// Factory for fetching Employee.
  const factory EmployeeEvent.fetchSalonEmployees(int salonId) =
      EmployeeEvent$FetchSalonEmployees;
}

/// [EmployeeEvent.fetchSalonEmployees] event.
final class EmployeeEvent$FetchSalonEmployees extends EmployeeEvent {
  const EmployeeEvent$FetchSalonEmployees(this.salonId) : super();

  ///
  final int salonId;
}

/// Employee events base class.
abstract base class _$EmployeeEventBase {
  const _$EmployeeEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, EmployeeEvent$FetchSalonEmployees>
        fetchSalonEmployees,
  }) =>
      switch (this) {
        final EmployeeEvent$FetchSalonEmployees s => fetchSalonEmployees(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, EmployeeEvent$FetchSalonEmployees>? fetchSalonEmployees,
  }) =>
      map<R>(
        fetchSalonEmployees: fetchSalonEmployees ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, EmployeeEvent$FetchSalonEmployees>? fetchSalonEmployees,
  }) =>
      map<R?>(
        fetchSalonEmployees: fetchSalonEmployees ?? (_) => null,
      );
}
