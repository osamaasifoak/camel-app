import 'dart:async' show FutureOr;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:postor/error_handler.dart' as eh show catchIt;
import 'package:postor/postor.dart';

import '/core/models/entertainment_show/entertainment_show_details.dart';
import '/core/models/entertainment_show/entertainment_show_reviews.dart';
import '/core/models/fav_entertainment_show/fav_entertainment_show.dart';
import '/core/repositories/base_eshows_repo.dart';
import '/core/repositories/base_fav_eshows_repo.dart';

part 'eshow_detail_state.dart';

class EShowDetailCubit extends Cubit<EShowDetailState> {
  EShowDetailCubit({
    required BaseEShowsRepository eShowRepo,
    required BaseFavEShowsRepository favEShowRepo,
  })  : _eShowRepo = eShowRepo,
        _favEShowRepo = favEShowRepo,
        super(EShowDetailState.init());

  final BaseEShowsRepository _eShowRepo;
  final BaseFavEShowsRepository _favEShowRepo;

  Future<void> loadDetail({
    required int id,
    required FutureOr<void> Function() onFail,
  }) async {
    try {
      final EShowDetails eShowDetails = await _eShowRepo.getDetails(
        id: id,
        requester: this,
      );
      final List<EShowReview> eShowReviews = await _eShowRepo.getReviews(
        id: id,
        requester: this,
      );
      final bool isFav = await _favEShowRepo.isFav(id);

      emit(
        state.update(
          status: EShowDetailStatus.loaded,
          eShowDetails: eShowDetails,
          eShowReviews: eShowReviews,
          isFav: isFav,
        ),
      );
    } catch (e, st) {
      if (e is! CancelledRequestException) {
        eh.catchIt(
          error: e,
          stackTrace: st,
          otherErrorMessage: 'Failed to load movie detail. Please try again.',
          onCatch: _catchError,
        );

        onFail();
      }
    }
  }

  Future<void> setFav({bool fav = true}) async {
    if (state.isLoading) return;
    try {
      if (fav) {
        await _favEShowRepo.insertFav(
          FavEShow.addedOnToday(showId: state.eShowDetails!.id),
        );
      } else {
        await _favEShowRepo.deleteFav(state.eShowDetails!.id);
      }

      emit(state.update(isFav: fav));
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
    emit(
      state.update(
        status: EShowDetailStatus.error,
        errorMessage: message,
      ),
    );
  }

  @override
  Future<void> close() {
    _eShowRepo.cancelAllRequestsMadeBy(this);
    return super.close();
  }
}
