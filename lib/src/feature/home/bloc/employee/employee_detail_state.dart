import 'package:flutter/foundation.dart';
import 'package:ln_studio/src/feature/home/model/review.dart';

import '/src/common/utils/pattern_match.dart';

/// {@template EmployeeDetail_state}
/// EmployeeDetailState.
/// {@endtemplate}
sealed class EmployeeDetailState extends _$EmployeeDetailStateBase {
  /// Idling state
  /// {@macro EmployeeDetail_state}
  const factory EmployeeDetailState.idle({
    required List<Review> reviews,
    String message,
  }) = EmployeeDetailState$Idle;

  /// Processing
  /// {@macro EmployeeDetail_state}
  const factory EmployeeDetailState.processing({
    required List<Review> reviews,
    String message,
  }) = EmployeeDetailState$Processing;

  /// Successful
  /// {@macro EmployeeDetail_state}
  const factory EmployeeDetailState.successful({
    required List<Review> reviews,
    String message,
  }) = EmployeeDetailState$Successful;

  /// An error has occurred
  /// {@macro EmployeeDetail_state}
  const factory EmployeeDetailState.error({
    required List<Review> reviews,
    String message,
  }) = EmployeeDetailState$Error;

  /// {@macro EmployeeDetail_state}
  const EmployeeDetailState({
    required super.reviews,
    required super.message,
  });
}

/// Idling state
/// {@nodoc}
final class EmployeeDetailState$Idle extends EmployeeDetailState
    with _$EmployeeDetailState {
  /// {@nodoc}
  const EmployeeDetailState$Idle({
    required super.reviews,
    super.message = 'Idling',
  });
}

/// Processing
/// {@nodoc}
final class EmployeeDetailState$Processing extends EmployeeDetailState
    with _$EmployeeDetailState {
  /// {@nodoc}
  const EmployeeDetailState$Processing({
    required super.reviews,
    super.message = 'Processing',
  });
}

/// Successful
/// {@nodoc}
final class EmployeeDetailState$Successful extends EmployeeDetailState
    with _$EmployeeDetailState {
  /// {@nodoc}
  const EmployeeDetailState$Successful({
    required super.reviews,
    super.message = 'Successful',
  });
}

/// Error
/// {@nodoc}
final class EmployeeDetailState$Error extends EmployeeDetailState
    with _$EmployeeDetailState {
  /// {@nodoc}
  const EmployeeDetailState$Error({
    required super.reviews,
    super.message = 'An error has occurred.',
  });
}

/// {@nodoc}
base mixin _$EmployeeDetailState on EmployeeDetailState {}

/// {@nodoc}
@immutable
abstract base class _$EmployeeDetailStateBase {
  /// {@nodoc}
  const _$EmployeeDetailStateBase({
    required this.reviews,
    required this.message,
  });

  /// Data entity payload.
  @nonVirtual
  final List<Review> reviews;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Has data?
  bool get hasEmployeeDetail => reviews.isNotEmpty;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(
        orElse: () => false,
        error: (_) => true,
      );

  bool get isImageLoaded => maybeMap(
        idle: (_) => true,
        processing: (s) => s.hasEmployeeDetail,
        orElse: () => false,
      );

  /// Is in progress state?
  bool get isProcessing => maybeMap<bool>(
        orElse: () => false,
        processing: (_) => true,
      );

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [EmployeeDetailState].
  R map<R>({
    required PatternMatch<R, EmployeeDetailState$Idle> idle,
    required PatternMatch<R, EmployeeDetailState$Processing> processing,
    required PatternMatch<R, EmployeeDetailState$Successful> successful,
    required PatternMatch<R, EmployeeDetailState$Error> error,
  }) =>
      switch (this) {
        EmployeeDetailState$Idle s => idle(s),
        EmployeeDetailState$Processing s => processing(s),
        EmployeeDetailState$Successful s => successful(s),
        EmployeeDetailState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [EmployeeDetailState].
  R maybeMap<R>({
    PatternMatch<R, EmployeeDetailState$Idle>? idle,
    PatternMatch<R, EmployeeDetailState$Processing>? processing,
    PatternMatch<R, EmployeeDetailState$Successful>? successful,
    PatternMatch<R, EmployeeDetailState$Error>? error,
    required R Function() orElse,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [EmployeeDetailState].
  R? mapOrNull<R>({
    PatternMatch<R, EmployeeDetailState$Idle>? idle,
    PatternMatch<R, EmployeeDetailState$Processing>? processing,
    PatternMatch<R, EmployeeDetailState$Successful>? successful,
    PatternMatch<R, EmployeeDetailState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  @override
  int get hashCode => reviews.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);
}
