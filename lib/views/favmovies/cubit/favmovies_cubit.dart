import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '/core/helpers/error_handler.dart';
import '/core/models/movie/movie.dart';
import '/core/repositories/favmovies_repo/base_favmovies_repo.dart';
import '/core/repositories/movies_repo/base_movies_repo.dart';

part 'favmovies_state.dart';

class FavMoviesCubit extends Cubit<FavMoviesState> {
  final _moviesRepo = GetIt.I<BaseMoviesRepository>();
  final _favMoviesRepo = GetIt.I<BaseFavMoviesRepository>();

  FavMoviesCubit() : super(const FavMoviesLoading());

  Future<void> loadFavMovies() async{

    if(state is FavMoviesLoaded) (state as FavMoviesLoaded).movies.clear();

    emit(const FavMoviesLoading());

    try{
      
      final localFavMovies = await _favMoviesRepo.getFavList();
      final movies = await _moviesRepo.getMovieListById(localFavMovies);
      emit(FavMoviesLoaded(movies: movies));

    }catch(e, st){
      ErrorHandler.catchIt(
        error: e,
        stackTrace: st,
        customUnknownErrorMessage: 'Failed to fetch favourite movies. Please try again.',
        onCatch: _catchError,
      );
    }
  }

  void _catchError(String message) => emit(FavMoviesError(message));

}
