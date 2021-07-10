import 'package:bloc/bloc.dart';
import 'package:camelmovies/core/helpers/error_handler.dart';
import 'package:camelmovies/core/models/movie/movie.dart';
import 'package:camelmovies/core/repositories/movies_repo.dart';
import 'package:equatable/equatable.dart';

part 'nowplaying_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  final MoviesRepository _moviesRepo;

  NowPlayingCubit({
    required MoviesRepository moviesRepo
  }) :  _moviesRepo = moviesRepo,
        super(NowPlayingState.init());

  Future<void> loadMovies({bool more = false}) async {
    if(
      state.status == NowPlayingStatus.loading ||
      state.status == NowPlayingStatus.loadingMore
    ) return;

    if(more) {

      emit(state.update(
        status: NowPlayingStatus.loadingMore,
      ));

    }else{
      if(state.movies.isNotEmpty) state.movies.clear();
      emit(state.update(
        movies: [],
        status: NowPlayingStatus.loading,
        page: 1,
      ));

    }
    
    try{

      if(more){

        final page = state.page + 1;
        final npMoreMovies = await _moviesRepo.getNowPlaying(page: page);
        state.movies.addAll(npMoreMovies);
        // await Future.delayed(Duration(seconds: 1));
        emit(state.update(
          status: NowPlayingStatus.loaded,
          page: page,
        ));

      }else{

        final npMovies = await _moviesRepo.getNowPlaying();
        emit(state.update(
          movies: npMovies,
          status: NowPlayingStatus.loaded,
        ));

      }

    }catch(e, st){

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
      status: NowPlayingStatus.error,
      errorMessage: message,
    ));
  }
  
}
