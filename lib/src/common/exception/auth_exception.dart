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

/// Phone already exists exception.
final class AuthException$PhoneExists extends AuthException {
  const AuthException$PhoneExists({super.message = 'Phone exists'})
      : super(code: ErrorCode.phoneExists);
}
