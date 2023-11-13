import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/src/feature/qr_code/model/qr_code.dart';

/// Datasource for ... data.
abstract interface class QRCodeDataProvider {
  /// Fetch ...
  Future<QRCode> loadQRFromServer();

  /// Fetch ...
  QRCode? loadQRFromCache();
}

/// Implementation of ... datasource.
class QRCodeDataProviderImpl implements QRCodeDataProvider {
  QRCodeDataProviderImpl({
    required this.restClient,
    required this.sharedPreferences,
  });

  /// REST client to call API.
  final Dio restClient;

  ///
  final SharedPreferences sharedPreferences;

  @override
  Future<QRCode> loadQRFromServer() async {
    /// TODO(zhorenty): Wait for backend.
    final response = await restClient.get('/api/v1/qr_code/me');
    sharedPreferences.setString('qr_code', jsonEncode(response)).ignore();
    return QRCode.fromJson(response.data['data']);
  }

  @override
  QRCode? loadQRFromCache() {
    /// TODO(zhorenty): Wait for backend.
    final qrCodeJson = sharedPreferences.getString('qr_code');
    if (qrCodeJson == null) return null;
    return QRCode.fromJson(jsonDecode(qrCodeJson) as Map<String, Object?>);
  }
}
