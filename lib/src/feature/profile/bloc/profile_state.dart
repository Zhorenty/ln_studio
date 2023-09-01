import 'package:flutter/foundation.dart';

import '../../../common/utils/pattern_match.dart';
import '../model/profile.dart';

///
sealed class ProfileState extends _$ProfileStateBase {
  const ProfileState._({
    super.profile,
    super.error,
  });

  ///
  const factory ProfileState.idle({
    Profile? profile,
    String? error,
  }) = _ProfileState$Idle;

  ///
  const factory ProfileState.processing({
    Profile? profile,
    String? error,
  }) = _ProfileState$Processing;
}

///
final class _ProfileState$Idle extends ProfileState {
  const _ProfileState$Idle({
    super.profile,
    super.error,
  }) : super._();
}

///
final class _ProfileState$Processing extends ProfileState {
  const _ProfileState$Processing({
    super.profile,
    super.error,
  }) : super._();
}

///
@immutable
abstract base class _$ProfileStateBase {
  const _$ProfileStateBase({
    this.profile,
    this.error,
  });

  @nonVirtual
  final Profile? profile;

  @nonVirtual
  final String? error;

  ///
  bool get hasError => error != null;

  ///
  bool get hasProfile => profile != null;

  ///
  bool get isProcessing => maybeMap(
        processing: (_) => true,
        orElse: () => false,
      );

  ///
  bool get isIdling => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );

  ///
  R map<R>({
    required PatternMatch<R, _ProfileState$Idle> idle,
    required PatternMatch<R, _ProfileState$Processing> processing,
  }) =>
      switch (this) {
        final _ProfileState$Idle idleState => idle(idleState),
        final _ProfileState$Processing processingState =>
          processing(processingState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  ///
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _ProfileState$Idle>? idle,
    PatternMatch<R, _ProfileState$Processing>? processing,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
      );

  @override
  String toString() => 'ProfileState(profile: $profile, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(profile, error);
}
