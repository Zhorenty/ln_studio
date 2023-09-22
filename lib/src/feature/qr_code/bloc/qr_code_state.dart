import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';
import '/src/feature/qr_code/model/qr_code.dart';

sealed class QRCodeState extends _$QRCodeStateBase {
  const QRCodeState._({super.qrCode, super.error});

  const factory QRCodeState.idle({
    QRCode? qrCode,
    String? error,
  }) = _QRCodeState$Idle;

  const factory QRCodeState.processing({
    QRCode? qrCode,
    String? error,
  }) = _QRCodeState$Processing;
}

final class _QRCodeState$Idle extends QRCodeState {
  const _QRCodeState$Idle({super.qrCode, super.error}) : super._();
}

final class _QRCodeState$Processing extends QRCodeState {
  const _QRCodeState$Processing({super.qrCode, super.error}) : super._();
}

@immutable
abstract base class _$QRCodeStateBase {
  const _$QRCodeStateBase({this.qrCode, this.error});

  @nonVirtual
  final QRCode? qrCode;

  @nonVirtual
  final String? error;

  bool get hasError => error != null;

  bool get hasQRCode => qrCode != null;

  bool get isProcessing => maybeMap(
        processing: (_) => true,
        orElse: () => false,
      );

  bool get isIdling => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );

  R map<R>({
    required PatternMatch<R, _QRCodeState$Idle> idle,
    required PatternMatch<R, _QRCodeState$Processing> processing,
  }) =>
      switch (this) {
        final _QRCodeState$Idle idleState => idle(idleState),
        final _QRCodeState$Processing processingState =>
          processing(processingState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _QRCodeState$Idle>? idle,
    PatternMatch<R, _QRCodeState$Processing>? processing,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
      );

  @override
  String toString() => 'QRCodeState(QRCode: $qrCode, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(qrCode, error);
}
