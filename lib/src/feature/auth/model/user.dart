import 'package:flutter/foundation.dart';

typedef TokenPair = ({
  String accessToken,
  String refreshToken,
});

@immutable
final class User {
  const User({this.phone});

  final String? phone;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && phone == other.phone;

  @override
  int get hashCode => phone.hashCode;
}
