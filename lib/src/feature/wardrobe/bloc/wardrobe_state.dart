import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';
import '/src/feature/wardrobe/model/cloth_entity.dart';

/// Wardrobe event.
sealed class WardrobeState extends _$WardrobeStateBase {
  const WardrobeState._({
    required super.clothes,
    super.error,
  });

  /// Wardrobe is idle.
  const factory WardrobeState.idle({
    List<ClothEntity> clothes,
    String? error,
  }) = _WardrobeState$Idle;

  /// Wardrobe is loaded.
  const factory WardrobeState.loaded({
    required List<ClothEntity> clothes,
    String? error,
  }) = _WardrobeState$Loaded;
}

/// [WardrobeState.idle] state matcher.
final class _WardrobeState$Idle extends WardrobeState {
  const _WardrobeState$Idle({
    super.clothes = const [],
    super.error,
  }) : super._();
}

/// [WardrobeState.loaded] state matcher.
final class _WardrobeState$Loaded extends WardrobeState {
  const _WardrobeState$Loaded({
    required super.clothes,
    super.error,
  }) : super._();
}

/// Wardrobe state base class.
@immutable
abstract base class _$WardrobeStateBase {
  const _$WardrobeStateBase({required this.clothes, this.error});

  @nonVirtual
  final List<ClothEntity> clothes;

  @nonVirtual
  final String? error;

  /// Indicator of whether there is an error.
  bool get hasError => error != null;

  /// Indicator whether clothes is not empty.
  bool get hasClothes => clothes.isNotEmpty;

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
    required PatternMatch<R, _WardrobeState$Idle> idle,
    required PatternMatch<R, _WardrobeState$Loaded> loaded,
  }) =>
      switch (this) {
        final _WardrobeState$Idle idleState => idle(idleState),
        final _WardrobeState$Loaded loadedState => loaded(loadedState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _WardrobeState$Idle>? idle,
    PatternMatch<R, _WardrobeState$Loaded>? loaded,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        loaded: loaded ?? (_) => orElse(),
      );

  @override
  String toString() => 'WardrobeState(Wardrobe: $clothes, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(clothes, error);
}
