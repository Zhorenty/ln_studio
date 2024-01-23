import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/feature/home/bloc/employee/employee_detail_event.dart';
import 'package:ln_studio/src/feature/home/bloc/employee/employee_detail_state.dart';
import 'package:ln_studio/src/feature/home/data/home_repository.dart';

/// Business Logic Component EmployeeDetailBLoC
class EmployeeDetailBLoC
    extends Bloc<EmployeeDetailEvent, EmployeeDetailState> {
  EmployeeDetailBLoC({
    required final HomeRepository repository,
    final EmployeeDetailState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const EmployeeDetailState.idle(
                reviews: [],
                message: 'Initial idle state',
              ),
        ) {
    on<EmployeeDetailEvent>(
      (event, emit) => switch (event) {
        EmployeeDetailEvent$FetchReviews() => _fetchReviews(event, emit),
      },
    );
  }

  ///
  final HomeRepository _repository;

  /// Fetch event handler
  Future<void> _fetchReviews(
    EmployeeDetailEvent$FetchReviews event,
    Emitter<EmployeeDetailState> emit,
  ) async {
    emit(EmployeeDetailState.processing(reviews: state.reviews));
    try {
      final reviews = await _repository.fetchReviews(event.employeeId);
      emit(EmployeeDetailState.successful(reviews: reviews));
    } on Object catch (err, _) {
      emit(EmployeeDetailState.error(reviews: state.reviews));
      rethrow;
    } finally {
      emit(EmployeeDetailState.idle(reviews: state.reviews));
    }
  }
}
