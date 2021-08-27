import 'dart:async' show FutureOr;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:postor/error_handler.dart' as eh show catchIt;

import '/core/models/fav_entertainment_show/fav_entertainment_show.dart';
import '/core/models/tv_show/tv_show_detail.dart';
import '/core/models/tv_show/tv_show_review.dart';
import '/core/repositories/fav_tv_shows_repo/base_fav_tv_shows_repo.dart';
import '/core/repositories/tv_show_repo/base_tv_show_repo.dart';

part 'tvshowdetail_state.dart';

class TVShowDetailCubit extends Cubit<TVShowDetailState> {
  final BaseTVShowRepository _tvShowRepo;
  final BaseFavTVShowsRepository _favTVShowsRepo;

  TVShowDetailCubit({
    BaseTVShowRepository? tvShowRepo,
    BaseFavTVShowsRepository? favTVShowsRepo,
  })  : _tvShowRepo = tvShowRepo ?? GetIt.I<BaseTVShowRepository>(),
        _favTVShowsRepo = favTVShowsRepo ?? GetIt.I<BaseFavTVShowsRepository>(),
        super(const TVShowDetailLoading());

  Future<void> loadTVShowDetail({
    required int tvShowId,
    required FutureOr<void> Function() onFail,
  }) async {
    try {
      final tvShowDetail = await _tvShowRepo.getTVShowDetail(tvShowId);
      final tvShowReviews = await _tvShowRepo.getTVShowReviews(tvShowId: tvShowId);
      final isFavTV = await _favTVShowsRepo.isFavTV(tvShowDetail.id);

      emit(
        TVShowDetailLoaded(
          tvShowDetail: tvShowDetail,
          tvShowReviews: tvShowReviews,
          isFavTV: isFavTV,
        ),
      );
    } catch (e, st) {
      eh.catchIt(
        error: e,
        stackTrace: st,
        otherErrorMessage: 'Failed to load TV show detail. Please try again.',
        onCatch: _catchError,
      );

      onFail();
    }
  }

  Future<void> setFav({bool fav = true}) async {
    if (state is! TVShowDetailLoaded) return;
    final currentState = state as TVShowDetailLoaded;
    try {
      if (fav) {
        await _favTVShowsRepo.insertFavTV(
          FavEShow.addedOnToday(showId: currentState.tvShowDetail.id),
        );
      } else {
        await _favTVShowsRepo.deleteFavTV(currentState.tvShowDetail.id);
      }

      emit(currentState.update(isFavTV: fav));
    } catch (e, st) {
      eh.catchIt(
        error: e,
        stackTrace: st,
        otherErrorMessage: 'Failed to save favourite TV show. Please try again.',
        onCatch: _catchError,
      );
    }
  }

  void _catchError(String message) {
    emit(TVShowDetailError(message));
  }
}
