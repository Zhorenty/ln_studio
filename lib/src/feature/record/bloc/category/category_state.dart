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

  /// Category is loaded.
  const factory CategoryState.loaded({
    required List<CategoryModel> categoryWithServices,
    String? error,
  }) = _CategoryState$Loaded;
}

/// [CategoryState.idle] state matcher.
final class _CategoryState$Idle extends CategoryState {
  const _CategoryState$Idle({
    super.categoryWithServices = const [],
    super.error,
  }) : super._();
}

/// [CategoryState.loaded] state matcher.
final class _CategoryState$Loaded extends CategoryState {
  const _CategoryState$Loaded({
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
    required PatternMatch<R, _CategoryState$Idle> idle,
    required PatternMatch<R, _CategoryState$Loaded> loaded,
  }) =>
      switch (this) {
        final _CategoryState$Idle idleState => idle(idleState),
        final _CategoryState$Loaded loadedState => loaded(loadedState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _CategoryState$Idle>? idle,
    PatternMatch<R, _CategoryState$Loaded>? loaded,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        loaded: loaded ?? (_) => orElse(),
      );

  @override
  String toString() =>
      'CategoryState(Category: $categoryWithServices, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(categoryWithServices, error);
}
