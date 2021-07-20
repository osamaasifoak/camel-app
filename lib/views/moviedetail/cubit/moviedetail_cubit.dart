import 'dart:async' show FutureOr;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '/core/helpers/error_handler.dart';
import '/core/models/movie/movie_detail.dart';
import '/core/repositories/favmovies_repo/base_favmovies_repo.dart';
import '/core/repositories/movies_repo/base_movies_repo.dart';

part 'moviedetail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final _moviesRepo = GetIt.I<BaseMoviesRepository>();
  final _favMoviesRepo = GetIt.I<BaseFavMoviesRepository>();

  MovieDetailCubit(): super(const MovieDetailLoading());

  Future<void> loadMovieDetail({required num? movieId, required FutureOr<void> Function() onFail}) async {
    if(movieId == null) {
      _catchError('Failed to load movie detail. Please try again.');
      return;
    }

    try{
      
      final movieDetail = await _moviesRepo.getMovieDetail(movieId);
      final isFav = await _favMoviesRepo.isFav(movieDetail.id);

      emit(
        MovieDetailLoaded(
          movieDetail: movieDetail,
          isFav: isFav,
        ),
      );

    }catch(e, st){

      ErrorHandler.catchIt(
        error: e,
        stackTrace: st,
        customUnknownErrorMessage: 'Failed to load movie detail. Please try again.',
        onCatch: _catchError,
      );

      onFail();

    }
  }

  Future<void> setFav([bool fav = true]) async{
    try{

      if(fav){

        await _favMoviesRepo.insertFav((state as MovieDetailLoaded).movieDetail.id);

      }else{

        await _favMoviesRepo.deleteFav((state as MovieDetailLoaded).movieDetail.id);

      }

      emit((state as MovieDetailLoaded).updateFav(fav));

    }catch(e, st) {
      
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
