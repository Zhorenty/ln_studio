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
  void signUp(String? phone);

  /// Sign in as a guest
  // void signInAnonymously();

  /// Sign up with [phone].
  // void signUpWithPhone(String phone);

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
  bool get isAuthenticated => user != null;
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
      // final router = AppRouterScope.of(context, listen: false);
      if (state is AuthState$Successful && _state?.phone != null) {
        router.goNamed('verify');
      } else if (state is AuthState$Successful && state.smsCode != null) {
        router.go('/home');
      } else if (state is AuthState$NotRegistered) {
        router.goNamed('register');
      }
      setState(() => _state = state);

      // TODO: Возможно, надо поменять
      // isAuthenticated
      //     ? router.replaceNamed('home')
      //     : router.replaceNamed('auth');
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
  void sendCode(String phone) {
    _authBloc.add(AuthEvent.sendCode(phone: phone));
    // if (_state!.isIdling) {
    //   router.goNamed('verify');
    // }
  }

  // @override
  // void signInAnonymously() => _authBloc.add(
  //       const AuthEvent.signInAnonymously(),
  //     );

  @override
  void signInWithPhone(int smsCode) {
    _authBloc.add(AuthEvent.signInWithPhone(smsCode));
    // if (_state!.isIdling) {
    //   router.go('/home');
    // }
  }

  @override
  void signUp(String? phone) {
    _authBloc.add(AuthEvent.signUp(phone));
    // if (_state!.isIdling) {
    //   router.go('/home');
    // }
  }

  // @override
  // void signUpWithPhone(String phone) => _authBloc.add(
  //       AuthEvent.signUpWithPhone(phone: phone),
  //     );

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
