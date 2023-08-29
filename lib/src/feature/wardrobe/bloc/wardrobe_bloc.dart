import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/feature/wardrobe/bloc/wardrobe_state.dart';
import '/src/feature/wardrobe/data/wardrobe_repository.dart';
import 'wardrobe_event.dart';

/// Wardrobe bloc.
class WardrobeBloc extends Bloc<WardrobeEvent, WardrobeState> {
  WardrobeBloc({required this.wardrobeRepository})
      : super(const WardrobeState.idle()) {
    on<WardrobeEvent>(
      (event, emit) => event.map(load: (e) => _load(e, emit)),
    );
  }

  ///
  final WardrobeRepository wardrobeRepository;

  Future<void> _load(
      WardrobeEvent$Load event, Emitter<WardrobeState> emit) async {
    try {
      final clothes = await wardrobeRepository.getAllClothes();
      return emit(
        WardrobeState.loaded(clothes: clothes),
      );
    } on Object catch (e) {
      emit(WardrobeState.idle(error: e.toString()));
      rethrow;
    }
  }
}
