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

    if (state.isBusy) return;

    emit(state.update(
      status: more ? UpcomingStatus.loadingMore : UpcomingStatus.loading,
      page: more ? state.page : 1,
    ));

    try {

      final nextPage = more ? state.page + 1 : 1;
      final movies = await _moviesRepo.getUpcoming(page: nextPage);

      emit(state.update(
        movies: state.movies + movies,
        status: UpcomingStatus.loaded,
        page: nextPage,
      ));

    } catch (e, st) {

      ErrorHandler.catchIt(
        error: e,
        stackTrace: st,
        customUnknownErrorMessage: 'Failed to fetch upcoming movies. Please try again.',
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
