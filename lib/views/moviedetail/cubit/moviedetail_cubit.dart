import 'dart:async' show FutureOr;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '/core/helpers/error_handler.dart';
import '/core/models/fav_entertainment_show/fav_entertainment_show.dart';
import '/core/models/movie/movie_detail.dart';
import '/core/models/movie/movie_review.dart';
import '/core/repositories/favmovies_repo/base_favmovies_repo.dart';
import '/core/repositories/movies_repo/base_movies_repo.dart';

part 'moviedetail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final BaseMoviesRepository _moviesRepo;
  final BaseFavMoviesRepository _favMoviesRepo;

  MovieDetailCubit({
    BaseMoviesRepository? moviesRepo,
    BaseFavMoviesRepository? favMoviesRepo,
  })  : _moviesRepo = moviesRepo ?? GetIt.I<BaseMoviesRepository>(),
        _favMoviesRepo = favMoviesRepo ?? GetIt.I<BaseFavMoviesRepository>(),
        super(const MovieDetailLoading());

  Future<void> loadMovieDetail({
    required int movieId,
    required FutureOr<void> Function() onFail,
  }) async {
    try {
      final movieDetail = await _moviesRepo.getMovieDetail(movieId);
      final movieReviews = await _moviesRepo.getMovieReviews(movieId: movieId);
      final isFav = await _favMoviesRepo.isFav(movieDetail.id);

      emit(
        MovieDetailLoaded(
          movieDetail: movieDetail,
          movieReviews: movieReviews,
          isFav: isFav,
        ),
      );
    } catch (e, st) {
      ErrorHandler.catchIt(
        error: e,
        stackTrace: st,
        customUnknownErrorMessage: 'Failed to load movie detail. Please try again.',
        onCatch: _catchError,
      );

      onFail();
    }
  }

  Future<void> setFav({bool fav = true}) async {
    if (state is! MovieDetailLoaded) return;
    final currentState = state as MovieDetailLoaded;
    try {
      if (fav) {
        await _favMoviesRepo.insertFav(
          FavEShow.addedOnToday(showId: currentState.movieDetail.id),
        );
      } else {
        await _favMoviesRepo.deleteFav(currentState.movieDetail.id);
      }

      emit(currentState.update(isFav: fav));
    } catch (e, st) {
      ErrorHandler.catchIt(
        error: e,
        stackTrace: st,
        customUnknownErrorMessage: 'Failed to save favourite movie. Please try again.',
        onCatch: _catchError,
      );
    }
  }

  void _catchError(String message) {
    emit(MovieDetailError(message));
  }
}
