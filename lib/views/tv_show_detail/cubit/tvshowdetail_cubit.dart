import 'dart:async' show FutureOr;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:postor/error_handler.dart' as eh show catchIt;

import '/core/constants/singletons_names.dart';
import '/core/models/fav_entertainment_show/fav_entertainment_show.dart';
import '/core/models/tv_show/tv_show_detail.dart';
import '/core/models/tv_show/tv_show_review.dart';
import '/core/repositories/base_eshows_repo.dart';
import '/core/repositories/base_fav_eshows_repo.dart';

part 'tvshowdetail_state.dart';

// TODO: Merge this into one single reusable Cubit
class TVShowDetailCubit extends Cubit<TVShowDetailState> {
  final BaseEShowsRepository _tvShowRepo;
  final BaseFavEShowsRepository _favTVShowsRepo;

  TVShowDetailCubit({
    BaseEShowsRepository? tvShowRepo,
    BaseFavEShowsRepository? favTVShowsRepo,
  })  : _tvShowRepo = tvShowRepo ?? GetIt.I<BaseEShowsRepository>(instanceName: SIName.repo.tvShows),
        _favTVShowsRepo = favTVShowsRepo ?? GetIt.I<BaseFavEShowsRepository>(instanceName: SIName.repo.favTVShows),
        super(const TVShowDetailLoading());

  Future<void> loadTVShowDetail({
    required int tvShowId,
    required FutureOr<void> Function() onFail,
  }) async {
    try {
      final TVShowDetail tvShowDetail = await _tvShowRepo.getDetails(id: tvShowId) as TVShowDetail;
      final List<TVShowReview> tvShowReviews = await _tvShowRepo.getReviews(id: tvShowId) as List<TVShowReview>;
      final bool isFavTV = await _favTVShowsRepo.isFav(tvShowDetail.id);

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
        await _favTVShowsRepo.insertFav(
          FavEShow.addedOnToday(showId: currentState.tvShowDetail.id),
        );
      } else {
        await _favTVShowsRepo.deleteFav(currentState.tvShowDetail.id);
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
