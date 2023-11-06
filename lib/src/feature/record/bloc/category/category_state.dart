import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';
import '/src/feature/record/model/category.dart';

/// Category states.
sealed class CategoryState extends _$CategoryStateBase {
  const CategoryState._({required super.categoryWithServices, super.error});

  /// Category is idle.
  const factory CategoryState.idle({
    List<CategoryModel> categoryWithServices,
    String? error,
  }) = _CategoryState$Idle;

  /// Category is Successful.
  const factory CategoryState.processing({
    required List<CategoryModel> categoryWithServices,
    String? error,
  }) = _CategoryState$Processing;

  /// Category is Successful.
  const factory CategoryState.successful({
    required List<CategoryModel> categoryWithServices,
    String? error,
  }) = _CategoryState$Successful;
}

/// [CategoryState.idle] state matcher.
final class _CategoryState$Idle extends CategoryState {
  const _CategoryState$Idle({
    super.categoryWithServices = const [],
    super.error,
  }) : super._();
}

/// [CategoryState.processing] state matcher.
final class _CategoryState$Processing extends CategoryState {
  const _CategoryState$Processing({
    super.categoryWithServices = const [],
    super.error,
  }) : super._();
}

/// [CategoryState.successful] state matcher.
final class _CategoryState$Successful extends CategoryState {
  const _CategoryState$Successful({
    required super.categoryWithServices,
    super.error,
  }) : super._();
}

/// Category state base class.
@immutable
abstract base class _$CategoryStateBase {
  const _$CategoryStateBase({required this.categoryWithServices, this.error});

  @nonVirtual
  final List<CategoryModel> categoryWithServices;

  @nonVirtual
  final String? error;

  /// Indicator of whether there is an error.
  bool get hasError => error != null;

  /// Indicator whether Category is not empty.
  bool get hasCategory => categoryWithServices.isNotEmpty;

  /// Indicator whether state is already Successful.
  bool get isSuccessful => maybeMap(
        successful: (_) => true,
        orElse: () => false,
      );

  /// Indicator whether state is already idling.
  bool get isIdling => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, _CategoryState$Idle> idle,
    required PatternMatch<R, _CategoryState$Processing> processing,
    required PatternMatch<R, _CategoryState$Successful> successful,
  }) =>
      switch (this) {
        final _CategoryState$Idle idleState => idle(idleState),
        final _CategoryState$Processing processingState =>
          processing(processingState),
        final _CategoryState$Successful successfulState =>
          successful(successfulState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _CategoryState$Idle>? idle,
    PatternMatch<R, _CategoryState$Processing>? processing,
    PatternMatch<R, _CategoryState$Successful>? successful,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
      );

  @override
  String toString() =>
      'CategoryState(Category: $categoryWithServices, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(categoryWithServices, error);
}
