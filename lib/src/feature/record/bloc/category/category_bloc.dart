import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/utils/error_util.dart';
import '/src/feature/record/data/record_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

/// Record bloc.
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.repository}) : super(const CategoryState.idle()) {
    on<CategoryEvent>(
      (event, emit) => event.map(
        fetchCategoryWithServices: (event) =>
            _fetchCategoryWithServices(event, emit),
      ),
    );
  }

  /// Repository for Record data.
  final RecordRepository repository;

  /// Fetch record from repository.
  Future<void> _fetchCategoryWithServices(
    CategoryEvent$FetchCategoryWithServices event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final categories = await repository.getCategories();
      emit(CategoryState.loaded(categoryWithServices: categories));
    } on Object catch (e) {
      emit(
        CategoryState.idle(
          categoryWithServices: state.categoryWithServices,
          error: ErrorUtil.formatError(e),
        ),
      );
      rethrow;
    }
  }
}
