import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/common/utils/error_util.dart';
import 'package:ln_studio/src/common/utils/mixin/set_state_mixin.dart';

import '../data/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with SetStateMixin {
  AuthBloc(this.authRepository) : super(const AuthState$Idle()) {
    // if (!authRepository.userStream.isBroadcast) {
    authRepository.userStream
        .map((user) => AuthState$Idle(user: user))
        .where(($state) => !identical($state, state))
        .listen(setState);
    // }

    on<AuthEvent>(
      (event, emit) => event.map(
        sendCode: (e) => _sendCode(e, emit),
        signInWithPhone: (e) => _signInWithPhone(e, emit),
        signUp: (e) => _signUp(e, emit),
        signOut: (e) => _signOut(e, emit),
      ),
    );
  }

  final AuthRepository authRepository;

  Future<void> _sendCode(
    AuthEvent$SendCode event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.processing(
      user: state.user,
      phone: event.phone,
      smsCode: null,
      uniqueRequestId: state.uniqueRequestId,
    ));
    try {
      final uniqueRequestId = await authRepository.sendCode(phone: event.phone);
      emit(AuthState.successful(
        user: state.user,
        phone: event.phone,
        smsCode: null,
        uniqueRequestId: uniqueRequestId,
      ));
    } on Object catch (e) {
      emit(AuthState.idle(
        error: ErrorUtil.formatError(e),
        uniqueRequestId: state.uniqueRequestId,
      ));
      rethrow;
    } finally {
      emit(AuthState.idle(
        user: state.user,
        phone: state.phone,
        uniqueRequestId: state.uniqueRequestId,
      ));
    }
  }

  Future<void> _signInWithPhone(
    AuthEventSignInWithPhone event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.processing(
      user: state.user,
      phone: state.phone,
      smsCode: event.smsCode,
      uniqueRequestId: state.uniqueRequestId,
    ));
    try {
      final user = await authRepository.signInWithPhone(
        phone: state.phone!,
        smsCode: event.smsCode,
        uniqueRequestId: state.uniqueRequestId ?? '1',
      );
      emit(AuthState.successful(
        user: user,
        phone: state.phone,
        smsCode: state.smsCode,
        uniqueRequestId: state.uniqueRequestId,
      ));
    } on Object catch (e) {
      if (e is DioException && e.response!.statusCode == 400) {
        emit(AuthState.notRegistered(
          user: state.user,
          phone: state.phone,
          smsCode: state.smsCode,
          uniqueRequestId: state.uniqueRequestId,
        ));
      } else {
        emit(AuthState.idle(
          error: ErrorUtil.formatError(e),
          uniqueRequestId: state.uniqueRequestId,
        ));
        rethrow;
      }
    }
  }

  Future<void> _signUp(
    AuthEvent$SignUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.processing(
      user: state.user,
      phone: state.phone,
      smsCode: null,
      uniqueRequestId: state.uniqueRequestId,
    ));
    try {
      final user = await authRepository.signUp(userModel: event.user);
      emit(AuthState.successful(
        user: user,
        phone: user.phone,
        smsCode: null,
        uniqueRequestId: state.uniqueRequestId,
      ));
    } on Object catch (e) {
      emit(AuthState.idle(
        error: ErrorUtil.formatError(e),
        uniqueRequestId: state.uniqueRequestId,
      ));
      rethrow;
    }
  }

  Future<void> _signOut(
    AuthEventSignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.processing(
      user: state.user,
      phone: null,
      smsCode: null,
      uniqueRequestId: state.uniqueRequestId,
    ));
    try {
      await authRepository.signOut();
      emit(const AuthState.successful(
        user: null,
        phone: null,
        smsCode: null,
        uniqueRequestId: null,
      ));
    } on Object catch (e) {
      emit(AuthState.idle(
        error: ErrorUtil.formatError(e),
        uniqueRequestId: state.uniqueRequestId,
      ));
      rethrow;
    }
  }
}
