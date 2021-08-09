import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '/core/enums/state_status.dart';
import '/core/helpers/error_handler.dart';
import '/core/models/tv_show/tv_show.dart';
import '/core/repositories/fav_tv_shows_repo/base_fav_tv_shows_repo.dart';
import '/core/repositories/tv_show_repo/base_tv_show_repo.dart';

part 'favtvshows_state.dart';

class FavTVShowsCubit extends Cubit<FavTVShowsState> {
  final BaseTVShowRepository _tvShowRepo;
  final BaseFavTVShowsRepository _favTVShowsRepo;

  FavTVShowsCubit({
    BaseTVShowRepository? tvShowRepo,
    BaseFavTVShowsRepository? favMoviesRepo,
  })  : _tvShowRepo = tvShowRepo ?? GetIt.I<BaseTVShowRepository>(),
        _favTVShowsRepo = favMoviesRepo ?? GetIt.I<BaseFavTVShowsRepository>(),
        super(FavTVShowsState.init());

  Future<void> loadFavTVShows({bool more = false}) async {
    if (state.isBusy || (more && state.isAtEndOfPage)) return;

    emit(more ? state.loadingMore() : state.loading());

    try {
      final int nextPage = more ? state.currentPage + 1 : 0;

      final localFavTVShows = await _favTVShowsRepo.getFavTVList(page: nextPage);
      if (localFavTVShows.isEmpty) {
        emit(state.loaded(
          tvShows: state.tvShows,
          isAtEndOfPage: true,
        ));
      } else {
        // we're gonna load the tv shows half by half
        // because loading all at once, especially more than 5
        // takes a bit too long
        final int firstHalf = localFavTVShows.length ~/ 2;
        final int secondHalf = localFavTVShows.length;

        final firstHalfTVShows = await _tvShowRepo.getTVShowListById(
          localFavTVShows.getRange(0, firstHalf).toList(growable: false),
        );

        emit(state.loadingMore(
          tvShows: state.tvShows + firstHalfTVShows,
        ));

        final secondHalfTVShows = await _tvShowRepo.getTVShowListById(
          localFavTVShows.getRange(firstHalf, secondHalf).toList(growable: false),
        );

        emit(state.loaded(
          tvShows: state.tvShows + secondHalfTVShows,
          newPage: nextPage,
        ));
      }
    } catch (e, st) {
      ErrorHandler.catchIt(
        error: e,
        stackTrace: st,
        customUnknownErrorMessage: 'Failed to fetch favourite TV shows. Please try again.',
        onCatch: _catchError,
      );
    }
  }

  void _catchError(String errorMessage) => emit(state.error(errorMessage: errorMessage));
}
