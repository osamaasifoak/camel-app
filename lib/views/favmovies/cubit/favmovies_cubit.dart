import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '/core/helpers/error_handler.dart';
import '/core/models/movie/movie.dart';
import '/core/repositories/movies_repo.dart';
import '/core/services/localdb_service/localdb_service.dart';

part 'favmovies_state.dart';

class FavMoviesCubit extends Cubit<FavMoviesState> {
  final MoviesRepository _moviesRepo;
  final LocalDbService _localDBRepo = GetIt.I<LocalDbService>();

  FavMoviesCubit({
    required MoviesRepository moviesRepo,
  }) :  _moviesRepo = moviesRepo,
        super(FavMoviesState.init());

  Future<void> loadFavMovies() async{

    if(state.movies.isNotEmpty) state.movies.clear();

    emit(state.update(
      status: FavMoviesStatus.loading,
    ));

    try{
      
      final localFavMovies = await _localDBRepo.getFavList();
      final movies = await _moviesRepo.getMovieListById(localFavMovies);
      emit(
        state.update(
          movies: movies,
          status: FavMoviesStatus.loaded,
          favCount: movies.length,
        )
      ); 
    }catch(e, st){
      ErrorHandler.catchIt(
        error: e,
        stackTrace: st,
        customUnknownErrorMessage: 'Failed to fetch favourite movies. Please try again.',
        onCatch: _catchError,
      );
    }
  }

  void _catchError(String message) {
    emit(state.update(
      status: FavMoviesStatus.error,
      errorMessage: message,
    ));
  }

}
