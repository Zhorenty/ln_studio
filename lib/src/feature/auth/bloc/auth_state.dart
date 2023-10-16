import 'package:flutter/foundation.dart';

import '../model/user.dart';

/// {@template auth_state}
/// AuthState.
/// {@endtemplate}
sealed class AuthState extends _$AuthStateBase {
  /// {@macro auth_state}
  const AuthState({
    required super.user,
    required super.phone,
    required super.message,
  });

  /// Idling state
  /// {@macro auth_state}
  const factory AuthState.idle({
    User? user,
    String? phone,
    String message,
    String? error,
  }) = AuthState$Idle;

  /// Processing
  /// {@macro auth_state}
  const factory AuthState.processing({
    required User? user,
    required String? phone,
    String message,
  }) = AuthState$Processing;

  /// Successful
  /// {@macro auth_state}
  const factory AuthState.successful({
    required User? user,
    required String? phone,
    String message,
  }) = AuthState$Successful;
}

/// Idling state
/// {@nodoc}
final class AuthState$Idle extends AuthState with _$AuthState {
  /// {@nodoc}
  const AuthState$Idle({
    super.user,
    super.phone,
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
    required super.phone,
    super.message = 'Successful',
  });

  @override
  String? get error => null;
}

/// Successful
/// {@nodoc}
final class AuthState$Successful extends AuthState with _$AuthState {
  /// {@nodoc}
  const AuthState$Successful({
    super.user,
    super.phone,
    super.message = 'Successful',
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
  const _$AuthStateBase({
    required this.user,
    required this.phone,
    required this.message,
  });

  /// Data entity payload.
  @nonVirtual
  final User? user;

  @nonVirtual
  final String? phone;

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
    required AuthStateMatch<R, AuthState$Successful> successful,
  }) =>
      switch (this) {
        final AuthState$Idle s => idle(s),
        final AuthState$Processing s => processing(s),
        final AuthState$Successful s => successful(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [AuthState].
  R maybeMap<R>({
    required R Function() orElse,
    AuthStateMatch<R, AuthState$Idle>? idle,
    AuthStateMatch<R, AuthState$Processing>? processing,
    AuthStateMatch<R, AuthState$Successful>? successful,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
      );

  /// Pattern matching for [AuthState].
  R? mapOrNull<R>({
    AuthStateMatch<R, AuthState$Idle>? idle,
    AuthStateMatch<R, AuthState$Processing>? processing,
    AuthStateMatch<R, AuthState$Successful>? successful,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
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
