import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '/core/helpers/error_handler.dart';
import '/core/models/movie/movie.dart';
import '/core/repositories/movies_repo/base_movies_repo.dart';

part 'upcoming_state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  final _moviesRepo = GetIt.I<BaseMoviesRepository>();

  UpcomingCubit(): super(UpcomingState.init());

  Future<void> loadMovies({bool more = false}) async {

    if (state.status == UpcomingStatus.loading ||
        state.status == UpcomingStatus.loadingMore) return;

    if (more) {

      emit(state.update(
        status: UpcomingStatus.loadingMore,
      ));

    } else {
      
      if(state.movies.isNotEmpty) state.movies.clear();
      emit(state.update(
        movies: [],
        status: UpcomingStatus.loading,
        page: 1,
      ));

    }
    try {

      if (more) {

        final page = state.page + 1;
        final ucMoreMovies = await _moviesRepo.getUpcoming(page: page);
        state.movies.addAll(ucMoreMovies);
        emit(state.update(
          status: UpcomingStatus.loaded,
          page: page,
        ));

      } else {

        final ucMovies = await _moviesRepo.getUpcoming();
        emit(state.update(
          movies: ucMovies,
          status: UpcomingStatus.loaded,
        ));

      }
    } catch (e, st) {

      ErrorHandler.catchIt(
        error: e,
        stackTrace: st,
        customUnknownErrorMessage: 'Failed to fetch movies. Please try again.',
        onCatch: _catchError,
      );

    }
  }

  void _catchError(String message) {

    emit(state.update(
      status: UpcomingStatus.error,
      errorMessage: message,
    ));

  }
}
