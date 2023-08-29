import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

@immutable
sealed class WardrobeEvent extends _$WardrobeEventBase {
  const WardrobeEvent();

  const factory WardrobeEvent.load() = WardrobeEvent$Load;
}

///
final class WardrobeEvent$Load extends WardrobeEvent {
  const WardrobeEvent$Load() : super();
}

///
abstract base class _$WardrobeEventBase {
  const _$WardrobeEventBase();

  ///
  R map<R>({required PatternMatch<R, WardrobeEvent$Load> load}) =>
      switch (this) {
        final WardrobeEvent$Load s => load(s),
        _ => throw AssertionError(),
      };

  ///
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, WardrobeEvent$Load>? load,
  }) =>
      map<R>(load: load ?? (_) => orElse());

  ///
  R? mapOrNull<R>({PatternMatch<R, WardrobeEvent$Load>? load}) => map<R?>(
        load: load ?? (_) => null,
      );
}
