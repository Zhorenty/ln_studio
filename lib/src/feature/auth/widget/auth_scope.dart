import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/router/router.dart';

import '../bloc/auth_event.dart';
import '/src/common/utils/mixin/scope_mixin.dart';
import '/src/feature/auth/bloc/auth_bloc.dart';
import '/src/feature/auth/bloc/auth_state.dart';
import '/src/feature/auth/model/user.dart';
import '/src/feature/initialization/widget/dependencies_scope.dart';

///
abstract mixin class AuthenticationController {
  void sendCode(String phone);

  /// Sign in with [phone].
  void signInWithPhone(int smsCode);

  /// Sign up
  void signUp({required User user});

  /// Sign out the current user
  void signOut();

  /// The current user
  User? get user;

  ///
  String? get phone;

  /// Whether the current user is being processed
  bool get isProcessing;

  /// The error message
  String? get error;

  /// Whether the current user is authenticated
  bool get isAuthenticated => user?.phone != null;
}

///
class AuthenticationScope extends StatefulWidget {
  const AuthenticationScope(this.child, {super.key});

  ///
  final Widget child;

  ////
  static AuthenticationController of(
    BuildContext context, {
    bool listen = true,
  }) =>
      ScopeMixin.scopeOf<_InheritedAuthentication>(
        context,
        listen: listen,
      ).controller;

  @override
  State<AuthenticationScope> createState() => _AuthenticationScopeState();
}

class _AuthenticationScopeState extends State<AuthenticationScope>
    with AuthenticationController {
  late final AuthBloc _authBloc;

  AuthState? _state;

  @override
  void initState() {
    _authBloc = AuthBloc(
      DependenciesScope.of(context).authRepository,
    )..stream.listen(_onAuthStateChanged);
    super.initState();
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  void _onAuthStateChanged(AuthState state) {
    if (!identical(state, _state)) {
      // Если надо сравнивать states
      setState(() => _state = state);

      // НОМЕР: 8 (960) 487-53-22
      final isNeedToRegister =
          state.smsCode != null && state is AuthState$NotRegistered;
      final isNeedToVerify =
          state.phone != null && state is AuthState$Successful;
      final isLogOuted = !isAuthenticated && state is AuthState$Successful;

      if (isAuthenticated) {
        return router.go('/home');
      } else {
        if (isNeedToRegister) {
          return router.goNamed('register');
        } else {
          if (isNeedToVerify) {
            return router.goNamed('verify');
          } else if (isLogOuted) {
            return router.goNamed('auth');
          }
        }
      }
    }
  }

  @override
  User? get user => _state?.user;

  @override
  String? get phone => _state?.phone;

  @override
  String? get error => _state?.error;

  @override
  bool get isProcessing => _state?.isProcessing ?? false;

  @override
  void sendCode(String phone) => _authBloc.add(
        AuthEvent.sendCode(phone: phone),
      );

  @override
  void signInWithPhone(int smsCode) => _authBloc.add(
        AuthEvent.signInWithPhone(smsCode),
      );

  @override
  void signUp({required User user}) => _authBloc.add(
        AuthEvent.signUp(user: user),
      );

  @override
  void signOut() => _authBloc.add(const AuthEvent.signOut());

  @override
  Widget build(BuildContext context) => _InheritedAuthentication(
        controller: this,
        state: _state,
        child: widget.child,
      );
}

///
class _InheritedAuthentication extends InheritedWidget {
  const _InheritedAuthentication({
    required this.controller,
    required this.state,
    required super.child,
  });

  ///
  final AuthState? state;

  ///
  final AuthenticationController controller;

  @override
  bool updateShouldNotify(_InheritedAuthentication oldWidget) =>
      state != oldWidget.state;
}
