import 'package:meta/meta.dart';

@immutable
abstract class NetworkException implements Exception {}

/// Base class for REST exceptions.
@immutable
class RestClientException implements NetworkException {
  const RestClientException({this.message, this.statusCode});

  /// Error message describing the network exception.
  final String? message;

  /// HTTP status code associated with the exception.
  final int? statusCode;

  @override
  String toString() =>
      'RestClientException(message: $message, statusCode: $statusCode)';
}

/// Internal server error.
@immutable
class InternalServerException implements NetworkException {
  const InternalServerException({this.message, this.statusCode});

  /// Error message describing the network exception.
  final String? message;

  /// HTTP status code associated with the exception.
  final int? statusCode;

  @override
  String toString() =>
      'InternalServerErrorException(message: $message, statusCode: $statusCode)';
}
