import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/feature/profile/data/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

///
final class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.profileRepository})
      : super(const ProfileState.idle()) {
    on<ProfileEvent>(
      (event, emit) => event.map(
        fetch: (e) => _fetch(e, emit),
      ),
    );
  }

  ///
  final ProfileRepository profileRepository;

  Future<void> _fetch(
    ProfileEvent$Fetch event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.processing());
    try {
      final profile = await profileRepository.getProfileFromServer();
      emit(ProfileState.idle(profile: profile));
    } on Object catch (e) {
      // emit(ProfileState.idle(error: ErrorUtil.formatError(e)));
      emit(ProfileState.idle(error: e.toString()));
      rethrow;
    }
  }
}
