import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/router/app_router_scope.dart';
import 'package:ln_studio/src/common/utils/mixin/scope_mixin.dart';
import 'package:ln_studio/src/feature/auth/bloc/auth_bloc.dart';
import 'package:ln_studio/src/feature/auth/bloc/auth_state.dart';
import 'package:ln_studio/src/feature/auth/model/user.dart';
import 'package:ln_studio/src/feature/initialization/widget/dependencies_scope.dart';

import '../bloc/auth_event.dart';

abstract mixin class AuthenticationController {
  /// Sign in with [email] and [password]
  void signInWithEmailAndPassword(String phone);

  /// Sign in as a guest
  // void signInAnonymously();

  /// Sign up with [email], [password] and [username]
  void signUpWithEmailAndPassword(String phone);

  /// Sign out the current user
  void signOut();

  /// The current user
  User? get user;

  /// Whether the current user is being processed
  bool get isProcessing;

  /// The error message
  String? get error;

  /// Whether the current user is authenticated
  bool get isAuthenticated => user != null;
}

class AuthenticationScope extends StatefulWidget {
  const AuthenticationScope(this.child, {super.key});

  final Widget child;

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
      setState(() => _state = state);
      final router = AppRouterScope.of(context, listen: false);

      if (state.user == null) {
        router.replaceNamed('home');
      } else {
        router.replaceNamed('auth');
      }
    }
  }

  @override
  User? get user => _state?.user;

  @override
  String? get error => _state?.error;

  @override
  bool get isProcessing => _state?.isProcessing ?? false;

  // @override
  // void signInAnonymously() => _authBloc.add(
  //       const AuthEvent.signInAnonymously(),
  //     );

  @override
  void signInWithEmailAndPassword(String phone) =>
      _authBloc.add(AuthEvent.signInWithPhone(phone: phone));

  @override
  void signUpWithEmailAndPassword(String phone) =>
      _authBloc.add(AuthEvent.signInWithPhone(phone: phone));

  @override
  void signOut() => _authBloc.add(const AuthEvent.signOut());

  @override
  Widget build(BuildContext context) => _InheritedAuthentication(
        controller: this,
        state: _state,
        child: widget.child,
      );
}

class _InheritedAuthentication extends InheritedWidget {
  const _InheritedAuthentication({
    required this.controller,
    required this.state,
    required super.child,
  });

  final AuthState? state;

  final AuthenticationController controller;

  @override
  bool updateShouldNotify(_InheritedAuthentication oldWidget) =>
      state != oldWidget.state;
}
