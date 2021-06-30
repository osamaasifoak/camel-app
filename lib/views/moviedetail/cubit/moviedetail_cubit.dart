import 'package:bloc/bloc.dart';
import 'package:camelmovies/core/helpers/error_handler.dart';
import 'package:camelmovies/core/services/navigation_service/navigation_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '/core/models/movie/movie_detail.dart';
import '/core/repositories/movies_repo.dart';
import '/core/services/localdb_service/localdb_service.dart';

part 'moviedetail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final MoviesRepository _moviesRepo;
  final LocalDbService _localDbService = GetIt.I<LocalDbService>();

  MovieDetailCubit({
    required MoviesRepository moviesRepo,
  }) :  _moviesRepo = moviesRepo,
        super(MovieDetailState.init());

  Future<void> loadMovieDetail(num? movieId) async {
    if(state.status == MovieDetailStatus.loading) return;
    
    emit(
      state.update(
        status: MovieDetailStatus.loading,
      ),
    );

    try{
      
      final movieDetail = await _moviesRepo.getMovieDetail(movieId);
      final isFav = await _localDbService.isFav(movieDetail.id);

      emit(
        state.update(
          movieDetail: movieDetail,
          status: MovieDetailStatus.loaded,
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

      Future.delayed(
        Duration(milliseconds: 250),
        GetIt.I<NavigationService>().back,
      );
    }
  }

  Future<void> setFav([bool fav = true]) async{
    try{
      if(fav){

        final setfav = await _localDbService.insertFav(state.movieDetail.id);
        
        if(setfav)
          emit(
            state.update(
              isFav: true,
            ),
          );
      }else{

        final delfav = await _localDbService.deleteFav(state.movieDetail.id);
        
        if(delfav)
          emit(
            state.update(
              isFav: false,
            ),
          );
      }
    }catch(e, st) {
      
      ErrorHandler.catchIt(
        error: e,
        stackTrace: st,
        customUnknownErrorMessage: 'Failed to save favourite movie. Please try again.',
        onCatch: _catchError,
      );

    }
  }

  void unloadMovieDetail(){
    emit(
      state.update(
        movieDetail: null,
        isFav: false,
        status: MovieDetailStatus.unloaded,
      )
    );
  }

  void _catchError(String message) {
    emit(state.update(
      status: MovieDetailStatus.error,
      errorMessage: message,
    ));
  }
}
