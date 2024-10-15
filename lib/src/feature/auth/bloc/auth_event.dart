import 'package:flutter/foundation.dart';

import '../model/user.dart';

@immutable
sealed class AuthEvent extends _$AuthEventBase {
  const AuthEvent();

  const factory AuthEvent.sendCode({required String phone}) =
      AuthEvent$SendCode;

  const factory AuthEvent.signInWithPhone(String smsCode) =
      AuthEventSignInWithPhone;

  const factory AuthEvent.signUp({required User user}) = AuthEvent$SignUp;

  const factory AuthEvent.signOut() = AuthEventSignOut;
}

final class AuthEvent$SendCode extends AuthEvent {
  const AuthEvent$SendCode({required this.phone});

  final String phone;
}

final class AuthEventSignInWithPhone extends AuthEvent {
  const AuthEventSignInWithPhone(this.smsCode);

  final String smsCode;

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
  const AuthEventSignOut();

  @override
  String toString() => 'AuthEvent.signOut()';
}

final class AuthEvent$SignUp extends AuthEvent {
  const AuthEvent$SignUp({required this.user});

  ///
  final User user;

  @override
  String toString() => 'AuthEvent.signIn(user: $user)';
}

typedef AuthEventMatch<R, S extends AuthEvent> = R Function(S event);

abstract base class _$AuthEventBase {
  const _$AuthEventBase();

  R map<R>({
    required AuthEventMatch<R, AuthEvent$SendCode> sendCode,
    required AuthEventMatch<R, AuthEventSignInWithPhone> signInWithPhone,
    required AuthEventMatch<R, AuthEvent$SignUp> signUp,
    required AuthEventMatch<R, AuthEventSignOut> signOut,
  }) =>
      switch (this) {
        final AuthEvent$SendCode s => sendCode(s),
        final AuthEventSignInWithPhone s => signInWithPhone(s),
        final AuthEvent$SignUp s => signUp(s),
        final AuthEventSignOut s => signOut(s),
        _ => throw AssertionError(),
      };

  R maybeMap<R>({
    required R Function() orElse,
    AuthEventMatch<R, AuthEvent$SendCode>? sendCode,
    AuthEventMatch<R, AuthEventSignInWithPhone>? signInWithPhone,
    AuthEventMatch<R, AuthEvent$SignUp>? signUp,
    AuthEventMatch<R, AuthEventSignOut>? signOut,
  }) =>
      map<R>(
        sendCode: sendCode ?? (_) => orElse(),
        signInWithPhone: signInWithPhone ?? (_) => orElse(),
        signUp: signUp ?? (_) => orElse(),
        signOut: signOut ?? (_) => orElse(),
      );

  R? mapOrNull<R>({
    AuthEventMatch<R, AuthEvent$SendCode>? sendCode,
    AuthEventMatch<R, AuthEventSignInWithPhone>? signInWithPhone,
    AuthEventMatch<R, AuthEvent$SignUp>? signUp,
    AuthEventMatch<R, AuthEventSignOut>? signOut,
  }) =>
      map<R?>(
        sendCode: sendCode ?? (_) => null,
        signInWithPhone: signInWithPhone ?? (_) => null,
        signUp: signUp ?? (_) => null,
        signOut: signOut ?? (_) => null,
      );
}
