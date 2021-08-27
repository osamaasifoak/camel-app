import 'package:get_it/get_it.dart';
import 'package:postor/error_handler.dart' as eh show catchIt;

import '/core/enums/state_status.dart';
import '/core/models/movie/movie.dart';
import '/core/repositories/movies_repo/base_movies_repo.dart';
import '/views/_screen_templates/movie/base_movie_list_cubit/base_movie_list_cubit.dart';

part 'nowplaying_state.dart';

class NowPlayingCubit extends BaseMovieListCubit<NowPlayingState> {

  NowPlayingCubit({
    BaseMoviesRepository? moviesRepo,
  })  : _moviesRepo = moviesRepo ?? GetIt.I<BaseMoviesRepository>(),
        super(NowPlayingState.init());

  final BaseMoviesRepository _moviesRepo;

  @override
  Future<void> loadMovies({bool more = false}) async {
    if (state.isBusy) return;

    emit(state.update(
      status: more ? StateStatus.loadingMore : StateStatus.loading,
      page: more ? state.page : 1,
    ));

    try {

        final nextPage = more ? state.page + 1 : 1;
        final movies = await _moviesRepo.getNowPlaying(page: nextPage);

        emit(state.update(
          movies: state.movies + movies,
          status: StateStatus.loaded,
          page: nextPage,
        ));

    } catch (e, st) {
      eh.catchIt(
        error: e,
        stackTrace: st,
        otherErrorMessage: 'Failed to fetch now playing movies. Please try again.',
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
