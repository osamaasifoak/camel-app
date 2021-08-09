import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '/core/enums/state_status.dart';
import '/core/helpers/error_handler.dart';
import '/core/models/movie/movie.dart';
import '/core/repositories/movies_repo/base_movies_repo.dart';
import '/core/repositories/movies_repo/movies2_repo/base_movies2_repo.dart';

part 'movies_sections_state.dart';

typedef BMR = BaseMoviesRepository;
typedef BMR2 = BaseMovies2Repository;

class MoviesSectionsCubit extends Cubit<MoviesSectionsState> {
  MoviesSectionsCubit({
    BMR2? movies2repo,
  })  : _movies2repo = movies2repo ?? (GetIt.I<BMR>() as BMR2),
        super(MoviesSectionsState.init());

  final BMR2 _movies2repo;

  Future<void> loadMoviesSections() async {
    if (state.isBusy) return;

    emit(state.update(
      status: StateStatus.loading,
    ));

    try {
      final popularMovies = await _movies2repo.getPopular();
      emit(state.update(
        popularMovies: popularMovies,
      ));

      final nowPlayingMovies = await _movies2repo.getNowPlaying();
      emit(state.update(
        nowPlayingMovies: nowPlayingMovies,
      ));

      final upcomingMovies = await _movies2repo.getUpcoming();
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
