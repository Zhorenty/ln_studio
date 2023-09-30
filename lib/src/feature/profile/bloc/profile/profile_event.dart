import 'package:flutter/foundation.dart';
import 'package:ln_studio/src/common/utils/pattern_match.dart';
import 'package:ln_studio/src/feature/profile/model/profile.dart';

sealed class ProfileEvent extends _$ProfileEventBase {
  const ProfileEvent._();

  const factory ProfileEvent.fetch() = ProfileEvent$Fetch;

  const factory ProfileEvent.edit({
    required ProfileModel profile,
  }) = ProfileEvent$Edit;
}

final class ProfileEvent$Fetch extends ProfileEvent {
  const ProfileEvent$Fetch() : super._();
}

final class ProfileEvent$Edit extends ProfileEvent {
  const ProfileEvent$Edit({required this.profile}) : super._();

  final ProfileModel profile;
}

@immutable
abstract base class _$ProfileEventBase {
  const _$ProfileEventBase();

  R map<R>({
    required PatternMatch<R, ProfileEvent$Fetch> fetch,
    required PatternMatch<R, ProfileEvent$Edit> edit,
  }) =>
      switch (this) {
        final ProfileEvent$Fetch fetchEvent => fetch(fetchEvent),
        final ProfileEvent$Edit editEvent => edit(editEvent),
        _ => throw UnsupportedError('Unsupported event: $this'),
      };

  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, ProfileEvent$Fetch>? fetch,
    PatternMatch<R, ProfileEvent$Edit>? edit,
  }) =>
      map(
        fetch: fetch ?? (_) => orElse(),
        edit: edit ?? (_) => orElse(),
      );

  @override
  String toString() => 'ProfileEvent()';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => 0;
}
