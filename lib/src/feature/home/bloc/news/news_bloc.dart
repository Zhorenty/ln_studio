import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/feature/home/bloc/news/news_event.dart';
import 'package:ln_studio/src/feature/home/bloc/news/news_state.dart';
import 'package:ln_studio/src/feature/home/data/home_repository.dart';

/// Business Logic Component NewsBLoC
class NewsBLoC extends Bloc<NewsEvent, NewsState> {
  NewsBLoC({
    required final HomeRepository repository,
    final NewsState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const NewsState.idle(news: null, message: 'Initial idle state'),
        ) {
    on<NewsEvent>(
      (event, emit) => switch (event) {
        NewsEvent$FetchAll() => _fetchAll(emit),
      },
    );
  }

  ///
  final HomeRepository _repository;

  /// Fetch event handler
  Future<void> _fetchAll(Emitter<NewsState> emit) async {
    emit(NewsState.processing(news: state.news));
    try {
      final news = await _repository.getNews();
      emit(NewsState.successful(news: news));
    } on Object catch (err, _) {
      emit(NewsState.error(news: state.news));
      rethrow;
    } finally {
      emit(NewsState.idle(news: state.news));
    }
  }
}
