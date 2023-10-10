import 'package:flutter/foundation.dart';

import '../model/user.dart';

/// {@template auth_state}
/// AuthState.
/// {@endtemplate}
sealed class AuthState extends _$AuthStateBase {
  /// {@macro auth_state}
  const AuthState({required super.user, required super.message});

  /// Idling state
  /// {@macro auth_state}
  const factory AuthState.idle({
    User? user,
    String message,
    String? error,
  }) = AuthState$Idle;

  /// Processing
  /// {@macro auth_state}
  const factory AuthState.processing({
    required User? user,
    String message,
  }) = AuthState$Processing;
}

/// Idling state
/// {@nodoc}
final class AuthState$Idle extends AuthState with _$AuthState {
  /// {@nodoc}
  const AuthState$Idle({
    super.user,
    super.message = 'Idling',
    this.error,
  });

  @override
  final String? error;
}

/// Processing
/// {@nodoc}
final class AuthState$Processing extends AuthState with _$AuthState {
  /// {@nodoc}
  const AuthState$Processing({
    required super.user,
    super.message = 'Processing',
  });

  @override
  String? get error => null;
}

/// {@nodoc}
base mixin _$AuthState on AuthState {}

/// Pattern matching for [AuthState].
typedef AuthStateMatch<R, S extends AuthState> = R Function(S state);

/// {@nodoc}
@immutable
abstract base class _$AuthStateBase {
  /// {@nodoc}
  const _$AuthStateBase({required this.user, required this.message});

  /// Data entity payload.
  @nonVirtual
  final User? user;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Error message.
  abstract final String? error;

  /// If an error has occurred?
  bool get hasError => error != null;

  /// Is in progress state?
  bool get isProcessing =>
      maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [AuthState].
  R map<R>({
    required AuthStateMatch<R, AuthState$Idle> idle,
    required AuthStateMatch<R, AuthState$Processing> processing,
  }) =>
      switch (this) {
        final AuthState$Idle s => idle(s),
        final AuthState$Processing s => processing(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [AuthState].
  R maybeMap<R>({
    required R Function() orElse,
    AuthStateMatch<R, AuthState$Idle>? idle,
    AuthStateMatch<R, AuthState$Processing>? processing,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
      );

  /// Pattern matching for [AuthState].
  R? mapOrNull<R>({
    AuthStateMatch<R, AuthState$Idle>? idle,
    AuthStateMatch<R, AuthState$Processing>? processing,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
      );

  @override
  int get hashCode => user.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write('AuthState(')
      ..write('user: $user, ');
    if (error != null) buffer.write('error: $error, ');
    buffer
      ..write('message: $message')
      ..write(')');
    return buffer.toString();
  }
}
