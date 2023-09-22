import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/utils/error_util.dart';
import '/src/feature/qr_code/bloc/qr_code_event.dart';
import '/src/feature/qr_code/bloc/qr_code_state.dart';
import '/src/feature/qr_code/data/qr_code_repository.dart';

///
final class QRCodeBloc extends Bloc<QRCodeEvent, QRCodeState> {
  QRCodeBloc({required this.qrCodeRepository})
      : super(const QRCodeState.idle()) {
    on<QRCodeEvent>(
      (event, emit) => event.map(
        fetch: (e) => _fetch(e, emit),
      ),
    );
  }

  ///
  final QRCodeRepository qrCodeRepository;

  ///
  Future<void> _fetch(
    QRCodeEvent$Fetch event,
    Emitter<QRCodeState> emit,
  ) async {
    emit(const QRCodeState.processing());
    try {
      final qrCodeFromCache = qrCodeRepository.getQRCodeFromCache();
      if (qrCodeFromCache != null) {
        emit(QRCodeState.idle(qrCode: qrCodeFromCache));
      }
      final qrCode = await qrCodeRepository.getQRCodeFromServer();
      emit(QRCodeState.idle(qrCode: qrCode));
    } on Object catch (e) {
      emit(QRCodeState.idle(error: ErrorUtil.formatError(e)));
      rethrow;
    }
  }
}
