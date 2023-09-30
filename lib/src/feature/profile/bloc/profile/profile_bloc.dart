import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/common/utils/error_util.dart';
import 'package:ln_studio/src/feature/profile/data/profile_repository.dart';

import 'profile_event.dart';
import 'profile_state.dart';

final class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.profileRepository})
      : super(const ProfileState.idle()) {
    on<ProfileEvent>(
      (event, emit) =>
          event.map(fetch: (e) => _fetch(e, emit), edit: (e) => _edit(e, emit)),
    );
  }

  final ProfileRepository profileRepository;

  Future<void> _fetch(
    ProfileEvent$Fetch event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.processing());
    try {
      final profileFromCache = profileRepository.getProfile();
      if (profileFromCache != null) {
        emit(ProfileState.idle(profile: profileFromCache));
      }
    } on Object catch (e) {
      emit(ProfileState.idle(error: ErrorUtil.formatError(e)));
      rethrow;
    }
  }

  Future<void> _edit(
    ProfileEvent$Edit event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.processing());
    try {
      // emit(ProfileState.idle(profile: profileFromCache));
    } on Object catch (e) {
      emit(ProfileState.idle(error: ErrorUtil.formatError(e)));
      rethrow;
    }
  }
}
