import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '/core/helpers/error_handler.dart';
import '/core/models/movie/movie.dart';
import '/core/repositories/movies_repo/base_movies_repo.dart';

part 'nowplaying_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  final _moviesRepo = GetIt.I<BaseMoviesRepository>();

  NowPlayingCubit() : super(NowPlayingState.init());

  Future<void> loadMovies({bool more = false}) async {
    if (state.isBusy) return;

    emit(state.update(
      status: more ? NowPlayingStatus.loadingMore : NowPlayingStatus.loading,
      page: more ? state.page : 1,
    ));

    try {

        final nextPage = more ? state.page + 1 : 1;
        final movies = await _moviesRepo.getNowPlaying(page: nextPage);

        emit(state.update(
          movies: state.movies + movies,
          status: NowPlayingStatus.loaded,
          page: nextPage,
        ));

    } catch (e, st) {
      ErrorHandler.catchIt(
        error: e,
        stackTrace: st,
        customUnknownErrorMessage: 'Failed to fetch now playing movies. Please try again.',
        onCatch: _catchError,
      );
    }
  }

  void _catchError(String message) {
    emit(state.update(
      status: NowPlayingStatus.error,
      errorMessage: message,
    ));
  }
}
