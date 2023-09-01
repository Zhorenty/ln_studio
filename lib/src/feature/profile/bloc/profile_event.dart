import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Repository for handling [Profile] related data.
sealed class ProfileEvent extends _$ProfileEventBase {
  const ProfileEvent._();

  ///
  const factory ProfileEvent.fetch() = ProfileEvent$Fetch;
}

///
final class ProfileEvent$Fetch extends ProfileEvent {
  const ProfileEvent$Fetch() : super._();
}

///
@immutable
abstract base class _$ProfileEventBase {
  const _$ProfileEventBase();

  ///
  R map<R>({
    required PatternMatch<R, ProfileEvent$Fetch> fetch,
  }) =>
      switch (this) {
        final ProfileEvent$Fetch fetchEvent => fetch(fetchEvent),
        _ => throw UnsupportedError('Unsupported event: $this'),
      };

  ///
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, ProfileEvent$Fetch>? fetch,
  }) =>
      map(fetch: fetch ?? (_) => orElse());

  @override
  String toString() => 'ProfileEvent()';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => 0;
}
