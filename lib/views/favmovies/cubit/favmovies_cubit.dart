import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:postor/error_handler.dart' as eh show catchIt;

import '/core/enums/state_status.dart';
import '/core/models/movie/movie.dart';
import '/core/repositories/favmovies_repo/base_favmovies_repo.dart';
import '/core/repositories/movies_repo/base_movies_repo.dart';

part 'favmovies_state.dart';

class FavMoviesCubit extends Cubit<FavMoviesState> {
  final BaseMoviesRepository _moviesRepo;
  final BaseFavMoviesRepository _favMoviesRepo;

  FavMoviesCubit({
    BaseMoviesRepository? moviesRepo,
    BaseFavMoviesRepository? favMoviesRepo,
  })  : _moviesRepo = moviesRepo ?? GetIt.I<BaseMoviesRepository>(),
        _favMoviesRepo = favMoviesRepo ?? GetIt.I<BaseFavMoviesRepository>(),
        super(FavMoviesState.init());

  Future<void> loadFavMovies({bool more = false}) async {
    if (state.isBusy || (more && state.isAtEndOfPage)) return;

    emit(more ? state.loadingMore() : state.loading());

    try {
      final int nextPage = more ? state.currentPage + 1 : 0;

      final localFavMovies = await _favMoviesRepo.getFavList(page: nextPage);
      if (localFavMovies.isEmpty) {
        emit(state.loaded(
          movies: state.movies,
          isAtEndOfPage: true,
        ));
      } else {
        // we're gonna load the movies half by half
        // because loading all at once, especially more than 5
        // takes a bit too long
        final int firstHalf = localFavMovies.length ~/ 2;
        final int secondHalf = localFavMovies.length;

        final firstHalfMovies = await _moviesRepo.getMovieListById(
          localFavMovies.getRange(0, firstHalf).toList(growable: false),
        );

        emit(state.loadingMore(
          movies: state.movies + firstHalfMovies,
        ));

        final secondHalfMovies = await _moviesRepo.getMovieListById(
          localFavMovies.getRange(firstHalf, secondHalf).toList(growable: false),
        );

        emit(state.loaded(
          movies: state.movies + secondHalfMovies,
          newPage: nextPage,
        ));
      }
    } catch (e, st) {
      eh.catchIt(
        error: e,
        stackTrace: st,
        otherErrorMessage: 'Failed to fetch favourite movies. Please try again.',
        onCatch: _catchError,
      );
    }
  }

  void _catchError(String errorMessage) => emit(state.error(errorMessage: errorMessage));
}
