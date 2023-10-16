import 'package:flutter/foundation.dart';

@immutable
sealed class AuthEvent extends _$AuthEventBase {
  const AuthEvent();

  const factory AuthEvent.sendCode({required String phone}) =
      AuthEvent$SendCode;

  // const factory AuthEvent.signInWithPhone({required String phone}) =
  //     AuthEventSignInWithPhone;

  // // const factory AuthEvent.signInAnonymously() = AuthEventSignInAnonymously;

  // const factory AuthEvent.signUpWithPhone({required String phone}) =
  //     AuthEventSignUpWithPhone;

  const factory AuthEvent.signOut() = AuthEventSignOut;
}

final class AuthEvent$SendCode extends AuthEvent {
  const AuthEvent$SendCode({required this.phone});

  final String phone;
}
// final class AuthEventSignUpWithPhone extends AuthEvent {
//   const AuthEventSignUpWithPhone({required this.phone}) : super();

//   final String phone;

//   @override
//   String toString() {
//     final buffer = StringBuffer()
//       ..write('AuthEvent.signUp(')
//       ..write('phone: $phone')
//       ..write(')');
//     return buffer.toString();
//   }
// }

// final class AuthEventSignInWithPhone extends AuthEvent {
//   const AuthEventSignInWithPhone({required this.phone}) : super();

//   final String phone;

//   @override
//   String toString() {
//     final buffer = StringBuffer()
//       ..write('AuthEvent.signIn(')
//       ..write('phone: $phone')
//       ..write(')');
//     return buffer.toString();
//   }
// }

// final class AuthEventSignInAnonymously extends AuthEvent {
//   const AuthEventSignInAnonymously() : super();

//   @override
//   String toString() => 'AuthEvent.signInAnonymously()';
// }

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
    // required AuthEventMatch<R, AuthEventSignInWithPhone> signInWithPhone,
    // required AuthEventMatch<R, AuthEventSignUpWithPhone> signUpWithPhone,
    // required AuthEventMatch<R, AuthEventSignInAnonymously> signInAnonymously,
    required AuthEventMatch<R, AuthEventSignOut> signOut,
  }) =>
      switch (this) {
        final AuthEvent$SendCode s => sendCode(s),
        // final AuthEventSignInWithPhone s => signInWithPhone(s),
        // final AuthEventSignUpWithPhone s => signUpWithPhone(s),
        // final AuthEventSignInAnonymously s => signInAnonymously(s),
        final AuthEventSignOut s => signOut(s),
        _ => throw AssertionError(),
      };

  R maybeMap<R>({
    required R Function() orElse,
    AuthEventMatch<R, AuthEvent$SendCode>? sendCode,
    // AuthEventMatch<R, AuthEventSignInWithPhone>? signInWithPhone,
    // AuthEventMatch<R, AuthEventSignUpWithPhone>? signUpWithPhone,
    // AuthEventMatch<R, AuthEventSignInAnonymously>? signInAnonymously,
    AuthEventMatch<R, AuthEventSignOut>? signOut,
  }) =>
      map<R>(
        sendCode: sendCode ?? (_) => orElse(),
        // signInWithPhone: signInWithPhone ?? (_) => orElse(),
        // signUpWithPhone: signUpWithPhone ?? (_) => orElse(),
        // signInAnonymously: signInAnonymously ?? (_) => orElse(),
        signOut: signOut ?? (_) => orElse(),
      );

  R? mapOrNull<R>({
    AuthEventMatch<R, AuthEvent$SendCode>? sendCode,
    // AuthEventMatch<R, AuthEventSignInWithPhone>? signInWithPhone,
    // AuthEventMatch<R, AuthEventSignUpWithPhone>? signUpWithPhone,
    // AuthEventMatch<R, AuthEventSignInAnonymously>? signInAnonymously,
    AuthEventMatch<R, AuthEventSignOut>? signOut,
  }) =>
      map<R?>(
        sendCode: sendCode ?? (_) => null,
        // signInWithPhone: signInWithPhone ?? (_) => null,
        // signInAnonymously: signInAnonymously ?? (_) => null,
        signOut: signOut ?? (_) => null,
        // signUpWithPhone: signUpWithPhone ?? (_) => null,
      );
}
