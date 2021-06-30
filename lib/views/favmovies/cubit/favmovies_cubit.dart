import 'package:bloc/bloc.dart';
import 'package:camelmovies/core/helpers/error_handler.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import 'package:camelmovies/core/models/movie/movie.dart';
import 'package:camelmovies/core/repositories/movies_repo.dart';
import 'package:camelmovies/core/services/localdb_service/localdb_service.dart';

part 'favmovies_state.dart';

class FavMoviesCubit extends Cubit<FavMoviesState> {
  final MoviesRepository _moviesRepo;
  final LocalDbService _localDBRepo = GetIt.I<LocalDbService>();

  FavMoviesCubit({
    required MoviesRepository moviesRepo,
  }) :  _moviesRepo = moviesRepo,
        super(FavMoviesState.init());

  Future<void> loadFavMovies() async{
    try{
      emit(
        state.update(
          status: FavMoviesStatus.loading,
        )
      );
      final localFavMovies = await _localDBRepo.getFavList();
      final movies = localFavMovies != null ? await _moviesRepo.getMovieListById(localFavMovies) : <Movie>[];
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
