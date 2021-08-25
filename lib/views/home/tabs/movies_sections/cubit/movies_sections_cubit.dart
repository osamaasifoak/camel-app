import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '/core/enums/state_status.dart';
import '/core/helpers/error_handler.dart';
import '/core/models/movie/movie.dart';
import '/core/repositories/movies_repo/base_movies_repo.dart';

part 'movies_sections_state.dart';

typedef BMR = BaseMoviesRepository;

class MoviesSectionsCubit extends Cubit<MoviesSectionsState> {
  MoviesSectionsCubit({
    BMR? moviesRepo,
  })  : _moviesRepo = moviesRepo ?? GetIt.I<BMR>(),
        super(MoviesSectionsState.init());

  final BMR _moviesRepo;

  Future<void> loadMoviesSections() async {
    if (state.isBusy) return;

    emit(state.update(
      status: StateStatus.loading,
    ));

    try {
      final popularMovies = await _moviesRepo.getPopular();
      emit(state.update(
        popularMovies: popularMovies,
      ));

      final nowPlayingMovies = await _moviesRepo.getNowPlaying();
      emit(state.update(
        nowPlayingMovies: nowPlayingMovies,
      ));

      final upcomingMovies = await _moviesRepo.getUpcoming();
      emit(state.update(
        status: StateStatus.loaded,
        upcomingMovies: upcomingMovies,
      ));
    } catch (error, stackTrace) {
      ErrorHandler.catchIt(
        error: error,
        stackTrace: stackTrace,
        customUnknownErrorMessage: "Something's wrong when loading movies sections :( Please try again",
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
