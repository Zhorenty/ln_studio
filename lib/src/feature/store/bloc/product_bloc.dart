import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ln_studio/src/feature/store/bloc/product_event.dart';
import 'package:ln_studio/src/feature/store/bloc/product_state.dart';
import 'package:ln_studio/src/feature/store/data/product_respository.dart';

/// Business Logic Component ProductBLoC
class ProductBLoC extends Bloc<ProductEvent, ProductState>
    implements EventSink<ProductEvent> {
  ProductBLoC({
    required final StoreRepository repository,
    final ProductState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const ProductState.idle(
                data: null,
                message: 'Initial idle state',
              ),
        ) {
    on<ProductEvent>(
      (event, emit) => switch (event) {
        ProductEvent$Fetch() => _fetch(event, emit),
      },
    );
  }

  final StoreRepository _repository;

  /// Fetch event handler
  Future<void> _fetch(
      ProductEvent$Fetch event, Emitter<ProductState> emit) async {
    try {
      emit(ProductState.processing(data: state.data));
      final newData = await _repository.fetchProducts();
      emit(ProductState.successful(data: newData));
    } on Object catch (_) {
      emit(ProductState.error(data: state.data));
      rethrow;
    } finally {
      emit(ProductState.idle(data: state.data));
    }
  }
}
