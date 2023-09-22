import 'package:flutter/material.dart';

import '/src/common/utils/pattern_match.dart';

sealed class QRCodeEvent extends _$QRCodeEventBase {
  const QRCodeEvent._();

  const factory QRCodeEvent.fetch() = QRCodeEvent$Fetch;
}

final class QRCodeEvent$Fetch extends QRCodeEvent {
  const QRCodeEvent$Fetch() : super._();
}

@immutable
abstract base class _$QRCodeEventBase {
  const _$QRCodeEventBase();

  R map<R>({
    required PatternMatch<R, QRCodeEvent$Fetch> fetch,
  }) =>
      switch (this) {
        final QRCodeEvent$Fetch fetchEvent => fetch(fetchEvent),
        _ => throw UnsupportedError('Unsupported event: $this'),
      };

  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, QRCodeEvent$Fetch>? fetch,
  }) =>
      map(
        fetch: fetch ?? (_) => orElse(),
      );

  @override
  String toString() => 'QRCodeEvent()';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => 0;
}
