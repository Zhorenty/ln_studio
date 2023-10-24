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
    required super.smsCode,
  });

  /// Idling state
  /// {@macro auth_state}
  const factory AuthState.idle({
    User? user,
    String? phone,
    int? smsCode,
    String message,
    String? error,
  }) = AuthState$Idle;

  /// Processing
  /// {@macro auth_state}
  const factory AuthState.processing({
    required User? user,
    required String? phone,
    required int? smsCode,
    String message,
  }) = AuthState$Processing;

  /// Successful
  /// {@macro auth_state}
  const factory AuthState.successful({
    required User? user,
    required String? phone,
    required int? smsCode,
    String message,
  }) = AuthState$Successful;

  /// Successful
  /// {@macro auth_state}
  const factory AuthState.notRegistered({
    required User? user,
    required String? phone,
    required int? smsCode,
    String message,
  }) = AuthState$NotRegistered;
}

/// Idling state
/// {@nodoc}
final class AuthState$Idle extends AuthState with _$AuthState {
  /// {@nodoc}
  const AuthState$Idle({
    super.user,
    super.phone,
    super.smsCode,
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
    required super.smsCode,
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
    super.smsCode,
    super.message = 'Successful',
  });

  @override
  String? get error => null;
}

/// Not Registered
/// {@nodoc}
final class AuthState$NotRegistered extends AuthState with _$AuthState {
  /// {@nodoc}
  const AuthState$NotRegistered({
    super.user,
    super.phone,
    super.smsCode,
    super.message = 'Not Registered',
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
    required this.smsCode,
  });

  /// Data entity payload.
  @nonVirtual
  final User? user;

  @nonVirtual
  final String? phone;

  @nonVirtual
  final int? smsCode;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Error message.
  abstract final String? error;

  /// If an error has occurred?
  bool get hasError => error != null;

  /// Is in progress state?
  bool get isSuccessful => maybeMap<bool>(
        orElse: () => false,
        successful: (_) => true,
      );

  /// Is in progress state?
  bool get isProcessing => maybeMap<bool>(
        orElse: () => false,
        processing: (_) => true,
      );

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [AuthState].
  R map<R>({
    required AuthStateMatch<R, AuthState$Idle> idle,
    required AuthStateMatch<R, AuthState$Processing> processing,
    required AuthStateMatch<R, AuthState$Successful> successful,
    required AuthStateMatch<R, AuthState$NotRegistered> notRegistered,
  }) =>
      switch (this) {
        final AuthState$Idle s => idle(s),
        final AuthState$Processing s => processing(s),
        final AuthState$Successful s => successful(s),
        final AuthState$NotRegistered s => notRegistered(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [AuthState].
  R maybeMap<R>({
    required R Function() orElse,
    AuthStateMatch<R, AuthState$Idle>? idle,
    AuthStateMatch<R, AuthState$Processing>? processing,
    AuthStateMatch<R, AuthState$Successful>? successful,
    AuthStateMatch<R, AuthState$NotRegistered>? notRegistered,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        notRegistered: notRegistered ?? (_) => orElse(),
      );

  /// Pattern matching for [AuthState].
  R? mapOrNull<R>({
    AuthStateMatch<R, AuthState$Idle>? idle,
    AuthStateMatch<R, AuthState$Processing>? processing,
    AuthStateMatch<R, AuthState$Successful>? successful,
    AuthStateMatch<R, AuthState$NotRegistered>? notRegistered,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        notRegistered: notRegistered ?? (_) => null,
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
