import 'package:flutter/foundation.dart';

@immutable
sealed class AuthEvent extends _$AuthEventBase {
  const AuthEvent();

  const factory AuthEvent.signInWithPhone({required String phone}) =
      AuthEventSignInWithEmailAndPassword;

  // const factory AuthEvent.signInAnonymously() = AuthEventSignInAnonymously;

  const factory AuthEvent.signUpWithPhone({required String phone}) =
      AuthEventSignUpWithEmailAndPassword;

  const factory AuthEvent.signOut() = AuthEventSignOut;
}

final class AuthEventSignUpWithEmailAndPassword extends AuthEvent {
  const AuthEventSignUpWithEmailAndPassword({required this.phone}) : super();

  final String phone;

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write('AuthEvent.signUp(')
      ..write('phone: $phone')
      ..write(')');
    return buffer.toString();
  }
}

final class AuthEventSignInWithEmailAndPassword extends AuthEvent {
  const AuthEventSignInWithEmailAndPassword({required this.phone}) : super();

  final String phone;

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write('AuthEvent.signIn(')
      ..write('phone: $phone')
      ..write(')');
    return buffer.toString();
  }
}

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
    required AuthEventMatch<R, AuthEventSignInWithEmailAndPassword>
        signInWithEmailAndPassword,
    // required AuthEventMatch<R, AuthEventSignInAnonymously> signInAnonymously,
    required AuthEventMatch<R, AuthEventSignOut> signOut,
    required AuthEventMatch<R, AuthEventSignUpWithEmailAndPassword>
        signUpWithEmailAndPassword,
  }) =>
      switch (this) {
        final AuthEventSignInWithEmailAndPassword s =>
          signInWithEmailAndPassword(s),
        // final AuthEventSignInAnonymously s => signInAnonymously(s),
        final AuthEventSignOut s => signOut(s),
        final AuthEventSignUpWithEmailAndPassword s =>
          signUpWithEmailAndPassword(s),
        _ => throw AssertionError(),
      };

  R maybeMap<R>({
    required R Function() orElse,
    AuthEventMatch<R, AuthEventSignInWithEmailAndPassword>?
        signInWithEmailAndPassword,
    // AuthEventMatch<R, AuthEventSignInAnonymously>? signInAnonymously,
    AuthEventMatch<R, AuthEventSignOut>? signOut,
    AuthEventMatch<R, AuthEventSignUpWithEmailAndPassword>?
        signUpWithEmailAndPassword,
  }) =>
      map<R>(
        signInWithEmailAndPassword:
            signInWithEmailAndPassword ?? (_) => orElse(),
        // signInAnonymously: signInAnonymously ?? (_) => orElse(),
        signOut: signOut ?? (_) => orElse(),
        signUpWithEmailAndPassword:
            signUpWithEmailAndPassword ?? (_) => orElse(),
      );

  R? mapOrNull<R>({
    AuthEventMatch<R, AuthEventSignInWithEmailAndPassword>?
        signInWithEmailAndPassword,
    // AuthEventMatch<R, AuthEventSignInAnonymously>? signInAnonymously,
    AuthEventMatch<R, AuthEventSignOut>? signOut,
    AuthEventMatch<R, AuthEventSignUpWithEmailAndPassword>?
        signUpWithEmailAndPassword,
  }) =>
      map<R?>(
        signInWithEmailAndPassword: signInWithEmailAndPassword ?? (_) => null,
        // signInAnonymously: signInAnonymously ?? (_) => null,
        signOut: signOut ?? (_) => null,
        signUpWithEmailAndPassword: signUpWithEmailAndPassword ?? (_) => null,
      );
}
