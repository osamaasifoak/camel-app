import 'dart:async' show FutureOr;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:postor/error_handler.dart' as eh show catchIt;

import '/core/constants/singletons_names.dart';
import '/core/models/fav_entertainment_show/fav_entertainment_show.dart';
import '/core/models/movie/movie_detail.dart';
import '/core/models/movie/movie_review.dart';
import '/core/repositories/base_eshows_repo.dart';
import '/core/repositories/base_fav_eshows_repo.dart';

part 'moviedetail_state.dart';

// TODO: Merge this into one single reusable Cubit
class MovieDetailCubit extends Cubit<MovieDetailState> {
  final BaseEShowsRepository _moviesRepo;
  final BaseFavEShowsRepository _favMoviesRepo;

  MovieDetailCubit({
    BaseEShowsRepository? moviesRepo,
    BaseFavEShowsRepository? favMoviesRepo,
  })  : _moviesRepo = moviesRepo ?? GetIt.I<BaseEShowsRepository>(instanceName: SIName.repo.movies),
        _favMoviesRepo = favMoviesRepo ?? GetIt.I<BaseFavEShowsRepository>(instanceName: SIName.repo.favMovies),
        super(const MovieDetailLoading());

  Future<void> loadMovieDetail({
    required int movieId,
    required FutureOr<void> Function() onFail,
  }) async {
    try {
      final MovieDetail movieDetail = await _moviesRepo.getDetails(id: movieId) as MovieDetail;
      final List<MovieReview> movieReviews = await _moviesRepo.getReviews(id: movieId) as List<MovieReview>;
      final bool isFav = await _favMoviesRepo.isFav(movieDetail.id);

      emit(
        MovieDetailLoaded(
          movieDetail: movieDetail,
          movieReviews: movieReviews,
          isFav: isFav,
        ),
      );
    } catch (e, st) {
      eh.catchIt(
        error: e,
        stackTrace: st,
        otherErrorMessage: 'Failed to load movie detail. Please try again.',
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
      eh.catchIt(
        error: e,
        stackTrace: st,
        otherErrorMessage: 'Failed to save favourite movie. Please try again.',
        onCatch: _catchError,
      );
    }
  }

  void _catchError(String message) {
    emit(MovieDetailError(message));
  }
}
