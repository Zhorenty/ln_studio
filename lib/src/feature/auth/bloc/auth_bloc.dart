import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/common/utils/error_util.dart';
import 'package:ln_studio/src/common/utils/mixin/set_state_mixin.dart';

import '../data/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with SetStateMixin {
  AuthBloc(this.authRepository) : super(const AuthState$Idle()) {
    authRepository.userStream
        .map((user) => AuthState$Idle(user: user))
        .where(($state) => !identical($state, state))
        .listen(setState);

    on<AuthEvent>(
      (event, emit) => event.map(
        sendCode: (e) => _sendCode(e, emit),
        // signInWithPhone: (e) => _signInWithPhone(e, emit),
        // signUpWithPhone: (e) => _signUpWithPhone(e, emit),
        // signInAnonymously: (e) => _signInAnonymously(e, emit),
        signOut: (e) => _signOut(e, emit),
      ),
    );
  }

  final AuthRepository authRepository;

  Future<void> _sendCode(
    AuthEvent$SendCode event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.processing(user: state.user));
    try {
      await authRepository.sendCode(phone: event.phone);
      emit(const AuthState.idle());
    } on Object catch (e) {
      emit(
        AuthState.idle(error: ErrorUtil.formatError(e)),
      );
      rethrow;
    }
  }

  // Future<void> _signUpWithPhone(
  //   AuthEventSignUpWithPhone event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   emit(AuthState.processing(user: state.user));
  //   try {
  //     final user = await authRepository.signUpWithPhone(
  //       phone: event.phone,
  //     );
  //     emit(AuthState.idle(user: user));
  //   } on Object catch (e) {
  //     emit(
  //       AuthState.idle(error: ErrorUtil.formatError(e)),
  //     );
  //     rethrow;
  //   }
  // }

  // Future<void> _signInWithPhone(
  //   AuthEventSignInWithPhone event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   emit(AuthState.processing(user: state.user));
  //   try {
  //     final user = await authRepository.signInWithPhone(phone: event.phone);
  //     emit(AuthState.idle(user: user));
  //   } on Object catch (e) {
  //     emit(
  //       AuthState.idle(error: ErrorUtil.formatError(e)),
  //     );
  //     rethrow;
  //   }
  // }

  // Future<void> _signInAnonymously(
  //   AuthEventSignInAnonymously event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   emit(AuthState.processing(user: state.user));
  //   try {
  //     final user = await authRepository.signInAnonymously();
  //     emit(
  //       AuthState.idle(user: user),
  //     );
  //   } on Object catch (e) {
  //     emit(
  //       AuthState.idle(error: ErrorUtil.formatError(e)),
  //     );
  //     rethrow;
  //   }
  // }

  Future<void> _signOut(
    AuthEventSignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.processing(user: state.user));
    try {
      await authRepository.signOut();
      emit(
        const AuthState.idle(),
      );
    } on Object catch (e) {
      emit(
        AuthState.idle(error: ErrorUtil.formatError(e)),
      );
      rethrow;
    }
  }
}
