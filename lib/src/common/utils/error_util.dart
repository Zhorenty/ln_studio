import 'dart:io';

import 'package:dio/dio.dart';

import '/src/common/exception/auth_exception.dart';
import '/src/common/exception/error_code.dart';
import '/src/common/localization/app_localization.dart';

/// Utility class for handling and formatting errors.
sealed class ErrorUtil {
  /// Formats an `AuthException` error message based on its type.
  static String formatError(Object error) => switch (error) {
        final AuthException e => _localizeAuthException(e),
        final DioException e => formatDioError(e),
        final Exception e => _localizeError(
            'Произошла ошибка: $e',
            (l) => l.exceptionOccurred(e.toString()),
          ),
        final dynamic e => _localizeError(
            'Неизвестная ошибка: $e',
            (l) => l.unknownError(e.toString()),
          ),
      };

  /// Formats a Dio exceptions.
  static String formatDioError(DioException error) => switch (error.error) {
        final SocketException _ => _localizeError(
            'Отсутствует подключение к интернету',
            null,
          ),
        final dynamic e => _localizeError(
            'Неизвестная ошибка: $e',
            (l) => l.unknownError(e.toString()),
          ),
      };

  /// Formats an `AuthException` error message based on its type.
  static String _localizeAuthException(AuthException exception) =>
      switch (exception) {
        final AuthException$PhoneExists _ => _localizeError(
            'Phone exists',
            (l) => l.phoneExists,
          ),
        _ => _localizeError(
            'Unknown',
            (l) => l.unknownError(exception.toString()),
          ),
      };

  /// Localizes an error message using the provided `localize` function.
  static String _localizeError(
    String fallback,
    String Function(Localization l)? localize,
  ) {
    try {
      return localize!(Localization.current!);
    } on Object {
      return fallback;
    }
  }

  /// `Never` returns as it always throws an exception.
  static Never throwAuthException(ErrorCode code, String message) =>
      throw switch (code) {
        ErrorCode.phoneNotFound => const AuthException$UserNotFound(),
        ErrorCode.phoneExists => const AuthException$PhoneExists(),
        ErrorCode.tokenMalformed => const AuthException$TokenMalformed(),
        ErrorCode.tokenExpired => const AuthException$RefreshTokenExpired(),
        ErrorCode.invalidBody => const AuthException$InvalidBody(),
        ErrorCode.unknown => AuthException$Unknown(message: message),
      };
}
