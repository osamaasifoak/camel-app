import 'package:get_it/get_it.dart';

import '/core/enums/state_status.dart';
import '/core/helpers/error_handler.dart';
import '/core/models/movie/movie.dart';
import '/core/repositories/movies_repo/base_movies_repo.dart';
import '/core/repositories/movies_repo/movies2_repo/base_movies2_repo.dart';
import '/views/_screen_templates/movie/base_movie_list_cubit/base_movie_list_cubit.dart';

part 'popular_state.dart';

class PopularCubit extends BaseMovieListCubit<PopularState> {

  PopularCubit({
    BaseMovies2Repository? moviesRepo,
  })  : _moviesRepo = moviesRepo ?? (GetIt.I<BaseMoviesRepository>() as BaseMovies2Repository),
        super(PopularState.init());

  final BaseMovies2Repository _moviesRepo;
  
  @override
  Future<void> loadMovies({bool more = false}) async {
    if (state.isBusy) return;

    emit(state.update(
      status: more ? StateStatus.loadingMore : StateStatus.loading,
      page: more ? state.page : 1,
    ));

    try {
      final nextPage = more ? state.page + 1 : 1;
      final movies = await _moviesRepo.getPopular(page: nextPage);

      emit(state.update(
        movies: state.movies + movies,
        status: StateStatus.loaded,
        page: nextPage,
      ));
    } catch (e, st) {
      ErrorHandler.catchIt(
        error: e,
        stackTrace: st,
        customUnknownErrorMessage: 'Failed to fetch popular movies. Please try again.',
        onCatch: _catchError,
      );
    }
  }

  void _catchError(String errorMessage) {
    emit(state.update(
      status: StateStatus.error,
      errorMessage: errorMessage,
    ));
  }
}
