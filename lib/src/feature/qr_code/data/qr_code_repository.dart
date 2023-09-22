import '/src/feature/qr_code/data/qr_code_data_provider.dart';
import '/src/feature/qr_code/model/qr_code.dart';

/// Repository for QRCode data.
abstract interface class QRCodeRepository {
  /// Get the QRCode of the current user from the server.
  Future<QRCode> getQRCodeFromServer();

  /// Get the QRCode of the current user from the cache.
  QRCode? getQRCodeFromCache();
}

/// Implementation of the QRCode repository.
final class QRCodeRepositoryImpl implements QRCodeRepository {
  QRCodeRepositoryImpl(this._dataProvider);

  /// QRCode data source.
  final QRCodeDataProvider _dataProvider;

  @override
  Future<QRCode> getQRCodeFromServer() async =>
      _dataProvider.loadQRFromServer();

  @override
  QRCode? getQRCodeFromCache() => _dataProvider.loadQRFromCache();
}
