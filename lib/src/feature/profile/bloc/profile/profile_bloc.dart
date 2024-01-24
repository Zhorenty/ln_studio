import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/utils/error_util.dart';
import '/src/feature/profile/data/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.profileRepository})
      : super(const ProfileState.idle()) {
    on<ProfileEvent>(
      (event, emit) => event.map(
        fetch: (e) => _fetch(e, emit),
        edit: (e) => _edit(e, emit),
      ),
    );
  }

  final ProfileRepository profileRepository;

  Future<void> _fetch(
    ProfileEvent$Fetch event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileState.processing(profile: state.profile));
    try {
      final profile = await profileRepository.getProfile();
      emit(ProfileState.successful(profile: profile));
    } on Object catch (e) {
      emit(ProfileState.idle(
        error: ErrorUtil.formatError(e),
        profile: state.profile,
      ));
      rethrow;
    }
  }

  Future<void> _edit(
    ProfileEvent$Edit event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileState.processing(profile: state.profile));
    try {
      final profile = await profileRepository.editProfile(event.profile);
      emit(ProfileState.successful(profile: profile));
    } on Object catch (e) {
      emit(ProfileState.idle(
          error: ErrorUtil.formatError(e), profile: state.profile));
      rethrow;
    }
  }
}
