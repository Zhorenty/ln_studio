import 'package:flutter/foundation.dart';

@immutable
sealed class AuthEvent extends _$AuthEventBase {
  const AuthEvent();

  const factory AuthEvent.sendCode({required String phone}) =
      AuthEvent$SendCode;

  const factory AuthEvent.signInWithPhone(int smsCode) =
      AuthEventSignInWithPhone;

  const factory AuthEvent.signOut() = AuthEventSignOut;
}

final class AuthEvent$SendCode extends AuthEvent {
  const AuthEvent$SendCode({required this.phone});

  final String phone;
}

final class AuthEventSignInWithPhone extends AuthEvent {
  const AuthEventSignInWithPhone(this.smsCode);

  final int smsCode;

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write('AuthEvent.signIn(')
      ..write('smsCode: $smsCode')
      ..write(')');
    return buffer.toString();
  }
}

final class AuthEventSignOut extends AuthEvent {
  const AuthEventSignOut() : super();

  @override
  String toString() => 'AuthEvent.signOut()';
}

typedef AuthEventMatch<R, S extends AuthEvent> = R Function(S event);

abstract base class _$AuthEventBase {
  const _$AuthEventBase();

  R map<R>({
    required AuthEventMatch<R, AuthEvent$SendCode> sendCode,
    required AuthEventMatch<R, AuthEventSignInWithPhone> signInWithPhone,
    required AuthEventMatch<R, AuthEventSignOut> signOut,
  }) =>
      switch (this) {
        final AuthEvent$SendCode s => sendCode(s),
        final AuthEventSignInWithPhone s => signInWithPhone(s),
        final AuthEventSignOut s => signOut(s),
        _ => throw AssertionError(),
      };

  R maybeMap<R>({
    required R Function() orElse,
    AuthEventMatch<R, AuthEvent$SendCode>? sendCode,
    AuthEventMatch<R, AuthEventSignInWithPhone>? signInWithPhone,
    AuthEventMatch<R, AuthEventSignOut>? signOut,
  }) =>
      map<R>(
        sendCode: sendCode ?? (_) => orElse(),
        signInWithPhone: signInWithPhone ?? (_) => orElse(),
        signOut: signOut ?? (_) => orElse(),
      );

  R? mapOrNull<R>({
    AuthEventMatch<R, AuthEvent$SendCode>? sendCode,
    AuthEventMatch<R, AuthEventSignInWithPhone>? signInWithPhone,
    AuthEventMatch<R, AuthEventSignOut>? signOut,
  }) =>
      map<R?>(
        sendCode: sendCode ?? (_) => null,
        signInWithPhone: signInWithPhone ?? (_) => null,
        signOut: signOut ?? (_) => null,
      );
}
