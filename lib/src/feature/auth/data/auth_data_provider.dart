import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/exception/error_code.dart';
import 'package:ln_studio/src/common/utils/error_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

abstract interface class AuthDataProvider {
  /// Returns the current [TokenPair].
  TokenPair? getTokenPair();

  /// Refreshes the current [TokenPair].
  Future<TokenPair> refreshTokenPair();

  /// Clear the current [TokenPair].
  Future<void> signOut();

  /// Returns a stream of [TokenPair]s.
  ///
  /// The stream will emit a new [TokenPair] whenever the user's
  /// authentication state changes.
  ///
  /// If the user is not authenticated, the stream will emit `null`.
  ///
  /// If the user is authenticated, the stream will emit a [TokenPair]
  ///
  /// When listener is added to the stream, the stream will emit the
  /// current [TokenPair] immediately.
  Stream<TokenPair?> get tokenPairStream;

  /// Returns a stream of [TokenPair]s.
  ///
  /// The stream will emit a new [User] whenever the user's
  /// authentication state changes.
  ///
  /// If the user is not authenticated, the stream will emit `null`.
  ///
  /// If the user is authenticated, the stream will emit a [User]
  ///
  /// When listener is added to the stream, the stream will emit the
  /// current [User] immediately.
  Stream<User?> get userStream;

  /// Returns the current [User].
  User? getUser();

  /// Attempts to sign in with the given [phone].
  Future<User> signInWithPhone({
    required String phone,
  });

  /// Attempts to sign up with the given [phone].
  Future<User> signUpWithPhone({
    required String phone,
  });

  // /// Attempts to sign in anonymously.
  // Future<User> signInAnonymously();
}

final class AuthDataProviderImpl implements AuthDataProvider {
  AuthDataProviderImpl({
    required String baseUrl,
    required SharedPreferences sharedPreferences,
    @visibleForTesting Dio? httpClient,
  })  : _sharedPreferences = sharedPreferences,
        client = httpClient ??
            Dio(
              BaseOptions(baseUrl: baseUrl),
            );

  final SharedPreferences _sharedPreferences;
  final Dio client;

  final _tokenPairController = StreamController<TokenPair?>();
  final _userController = StreamController<User?>();

  Future<void> _saveTokenPair(TokenPair pair) async {
    await _sharedPreferences.setString(
      'auth.token_pair.access_token',
      pair.accessToken,
    );
    await _sharedPreferences.setString(
      'auth.token_pair.refresh_token',
      pair.refreshToken,
    );
    _tokenPairController.add(pair);
  }

  Future<void> _saveUser(User user) async {
    if (user.phone != null) {
      await _sharedPreferences.setString(
        'auth.user.phone',
        user.phone!,
      );
    }
    // await _sharedPreferences.setBool(
    //   'auth.user.is_anonymous',
    //   user.isAnonymous,
    // );
    _userController.add(user);
  }

  TokenPair _decodeTokenPair(Response<Map<String, Object?>> response) {
    final json = response.data;

    if (json
        case {
          'error': {
            'message': final String message,
            'code': final int code,
          }
        }) {
      final errorCode = ErrorCode.fromInt(code);

      ErrorUtil.throwAuthException(errorCode, message);
    }

    if (json
        case {
          'data': {
            'accessToken': final String accessToken,
            'refreshToken': final String refreshToken,
          },
        }) {
      return (
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    }

    throw const FormatException('Failed to decode token pair');
  }

  @override
  Future<TokenPair> refreshTokenPair() async {
    final tokenPair = getTokenPair();

    if (tokenPair == null) {
      throw Exception('Failed to refresh token pair');
    }

    final response = await client.get<Map<String, Object?>>(
      '/api/v1/auth/refresh',
      queryParameters: {
        'refreshToken': tokenPair.refreshToken,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to refresh token pair');
    }

    final newTokenPair = _decodeTokenPair(response);
    await _saveTokenPair(newTokenPair);

    return newTokenPair;
  }

  // @override
  // Future<User> signInAnonymously() async {
  //   final response = await client.post<Map<String, Object?>>(
  //     '/api/v1/auth/guest',
  //   );

  //   final tokenPair = _decodeTokenPair(response);

  //   await _saveTokenPair(tokenPair);

  //   const user = User(isAnonymous: true);

  //   await _saveUser(user);

  //   return user;
  // }

  @override
  Future<User> signInWithPhone({
    required String phone,
  }) async {
    final response = await client.post<Map<String, Object?>>(
      '/api/v1/auth/signin',
      data: jsonEncode({
        'phone': phone,
      }),
    );

    final tokenPair = _decodeTokenPair(response);

    await _saveTokenPair(tokenPair);

    final user = User(phone: phone);

    await _saveUser(user);

    return user;
  }

  @override
  Future<User> signUpWithPhone({
    required String phone,
  }) async {
    final response = await client.post<Map<String, Object?>>(
      '/api/v1/auth/signup',
      data: jsonEncode({
        'phone': phone,
      }),
    );

    final tokenPair = _decodeTokenPair(response);

    await _saveTokenPair(tokenPair);

    final user = User(phone: phone);

    await _saveUser(user);

    return user;
  }

  @override
  Future<void> signOut() async {
    await _sharedPreferences.remove('auth.token_pair.access_token');
    await _sharedPreferences.remove('auth.token_pair.refresh_token');
    await _sharedPreferences.remove('auth.user.phone');
    // await _sharedPreferences.remove('auth.user.is_anonymous');
    _tokenPairController.add(null);
    _userController.add(null);
    return;
  }

  @override
  TokenPair? getTokenPair() {
    final accessToken = _sharedPreferences.getString(
      'auth.token_pair.access_token',
    );
    final refreshToken = _sharedPreferences.getString(
      'auth.token_pair.refresh_token',
    );

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    return (
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  late final Stream<TokenPair?> tokenPairStream =
      _tokenPairController.stream.asBroadcastStream(
    onListen: (subscription) => _tokenPairController.add(getTokenPair()),
  );

  @override
  User? getUser() {
    final phone = _sharedPreferences.getString('auth.user.phone');

    // final isAnonymous = _sharedPreferences.getBool('auth.user.is_anonymous');

    // if (isAnonymous == null) {
    //   return null;
    // }

    return User(phone: phone);
  }

  @override
  Stream<User?> get userStream => _userController.stream.asBroadcastStream(
        onListen: (subscription) => _userController.add(getUser()),
      );
}
