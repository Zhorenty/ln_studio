/// Used to represent different error codes.
enum ErrorCode {
  /// Represents an unknown error.
  unknown(1),

  /// Error where the phone number already exists.
  phoneExists(2);

  const ErrorCode(this.code);

  /// Error code associated with this error.
  final int code;

  /// Converts an integer value to the corresponding `ErrorCode`
  static ErrorCode fromInt(int value) => ErrorCode.values.firstWhere(
        (element) => element.code == value,
        orElse: () => unknown,
      );

  @override
  String toString() => 'ErrorCode: $code $name';
}
