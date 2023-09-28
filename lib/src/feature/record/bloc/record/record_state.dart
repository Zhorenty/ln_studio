import 'package:flutter/foundation.dart';
import 'package:ln_studio/src/feature/record/model/category.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/record/model/timetable.dart';
import 'package:ln_studio/src/feature/salon/models/salon.dart';

/// {@template record_state}
/// RecordState.
/// {@endtemplate}
sealed class RecordState extends _$RecordStateBase {
  /// Idling state
  /// {@macro record_state}
  const factory RecordState.idle({
    required ServiceModel? service,
    required EmployeeModel? employee,
    required DateTime? date,
    required Salon? salon,
    required TimetableItem? timetableItem,
    required String? comment,
    String message,
  }) = RecordState$Idle;

  /// Processing
  /// {@macro record_state}
  const factory RecordState.processing({
    required ServiceModel? service,
    required EmployeeModel? employee,
    required DateTime? date,
    required Salon? salon,
    required TimetableItem? timetableItem,
    required String? comment,
    String message,
  }) = RecordState$Processing;

  /// Successful
  /// {@macro record_state}
  const factory RecordState.successful({
    required ServiceModel? service,
    required EmployeeModel? employee,
    required DateTime? date,
    required Salon? salon,
    required TimetableItem? timetableItem,
    required String? comment,
    String message,
  }) = RecordState$Successful;

  /// An error has occurred
  /// {@macro record_state}
  const factory RecordState.error({
    required ServiceModel? service,
    required EmployeeModel? employee,
    required DateTime? date,
    required Salon? salon,
    required TimetableItem? timetableItem,
    required String? comment,
    String message,
  }) = RecordState$Error;

  /// {@macro record_state}
  const RecordState({
    required super.service,
    required super.employee,
    required super.date,
    required super.salon,
    required super.timetableItem,
    required super.comment,
    required super.message,
  });
}

/// Idling state
/// {@nodoc}
final class RecordState$Idle extends RecordState with _$RecordState {
  /// {@nodoc}
  const RecordState$Idle({
    required super.service,
    required super.employee,
    required super.date,
    required super.salon,
    required super.timetableItem,
    required super.comment,
    super.message = 'Idling',
  });
}

/// Processing
/// {@nodoc}
final class RecordState$Processing extends RecordState with _$RecordState {
  /// {@nodoc}
  const RecordState$Processing({
    required super.service,
    required super.employee,
    required super.date,
    required super.salon,
    required super.timetableItem,
    required super.comment,
    super.message = 'Processing',
  });
}

/// Successful
/// {@nodoc}
final class RecordState$Successful extends RecordState with _$RecordState {
  /// {@nodoc}
  const RecordState$Successful({
    required super.service,
    required super.employee,
    required super.date,
    required super.salon,
    required super.timetableItem,
    required super.comment,
    super.message = 'Successful',
  });
}

/// Error
/// {@nodoc}
final class RecordState$Error extends RecordState with _$RecordState {
  /// {@nodoc}
  const RecordState$Error({
    required super.service,
    required super.employee,
    required super.date,
    required super.salon,
    required super.timetableItem,
    required super.comment,
    super.message = 'An error has occurred.',
  });
}

/// {@nodoc}
base mixin _$RecordState on RecordState {}

/// Pattern matching for [RecordState].
typedef RecordStateMatch<R, S extends RecordState> = R Function(S state);

/// {@nodoc}
@immutable
abstract base class _$RecordStateBase {
  /// {@nodoc}
  const _$RecordStateBase({
    required this.service,
    required this.employee,
    required this.date,
    required this.salon,
    required this.timetableItem,
    required this.comment,
    required this.message,
  });

  @nonVirtual
  final ServiceModel? service;

  @nonVirtual
  final EmployeeModel? employee;

  @nonVirtual
  final DateTime? date;

  @nonVirtual
  final Salon? salon;

  @nonVirtual
  final TimetableItem? timetableItem;

  @nonVirtual
  final String? comment;

  /// Message or state description.
  @nonVirtual
  final String message;

  bool get hasService => service != null;
  bool get hasEmployee => employee != null;
  bool get hasDate => date != null;
  bool get hasSalon => salon != null;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  /// Is in progress state?
  bool get isProcessing => maybeMap<bool>(
        orElse: () => false,
        processing: (_) => true,
        successful: (_) => false,
      );

  /// Is in progress state?
  bool get isSuccessful => maybeMap<bool>(
        orElse: () => false,
        processing: (_) => false,
        successful: (_) => true,
      );

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [RecordState].
  R map<R>({
    required RecordStateMatch<R, RecordState$Idle> idle,
    required RecordStateMatch<R, RecordState$Processing> processing,
    required RecordStateMatch<R, RecordState$Successful> successful,
    required RecordStateMatch<R, RecordState$Error> error,
  }) =>
      switch (this) {
        RecordState$Idle s => idle(s),
        RecordState$Processing s => processing(s),
        RecordState$Successful s => successful(s),
        RecordState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [RecordState].
  R maybeMap<R>({
    RecordStateMatch<R, RecordState$Idle>? idle,
    RecordStateMatch<R, RecordState$Processing>? processing,
    RecordStateMatch<R, RecordState$Successful>? successful,
    RecordStateMatch<R, RecordState$Error>? error,
    required R Function() orElse,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [RecordState].
  R? mapOrNull<R>({
    RecordStateMatch<R, RecordState$Idle>? idle,
    RecordStateMatch<R, RecordState$Processing>? processing,
    RecordStateMatch<R, RecordState$Successful>? successful,
    RecordStateMatch<R, RecordState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  @override
  int get hashCode => 0;

  @override
  bool operator ==(Object other) => identical(this, other);
}
