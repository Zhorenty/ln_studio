import 'package:flutter/foundation.dart';

import '/src/common/utils/annotation.dart';
import 'error_code.dart';

/// Custom errors.
@immutable
@exception
sealed class AuthException implements Exception {
  const AuthException({required this.message, required this.code});

  /// Error message.
  final String message;

  /// Error code.
  final ErrorCode code;

  @override
  String toString() => 'AuthException: $message, code: $code';
}

/// Unknown exception.
final class AuthException$Unknown extends AuthException {
  const AuthException$Unknown({super.message = 'Unknown'})
      : super(code: ErrorCode.unknown);
}

final class AuthException$UserNotFound extends AuthException {
  const AuthException$UserNotFound()
      : super(message: 'Phone not found', code: ErrorCode.phoneNotFound);
}

/// Phone already exists exception.
final class AuthException$PhoneExists extends AuthException {
  const AuthException$PhoneExists({super.message = 'Phone exists'})
      : super(code: ErrorCode.phoneExists);
}

final class AuthException$InvalidBody extends AuthException {
  const AuthException$InvalidBody()
      : super(message: 'Invalid body', code: ErrorCode.invalidBody);
}

final class AuthException$TokenMalformed extends AuthException {
  const AuthException$TokenMalformed()
      : super(message: 'Token malformed', code: ErrorCode.tokenMalformed);
}

final class AuthException$RefreshTokenExpired extends AuthException {
  const AuthException$RefreshTokenExpired()
      : super(message: 'Refresh token expired', code: ErrorCode.tokenExpired);
}
