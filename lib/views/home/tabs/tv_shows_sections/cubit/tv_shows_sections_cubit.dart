import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:postor/error_handler.dart' as eh show catchIt;

import '/core/enums/state_status.dart';
import '/core/models/tv_show/tv_show.dart';
import '/core/repositories/tv_show_repo/base_tv_show_repo.dart';

part 'tv_shows_sections_state.dart';

class TVShowsSectionsCubit extends Cubit<TVShowsSectionsState> {
  TVShowsSectionsCubit({
    BaseTVShowRepository? tvShowRepo,
  })  : _tvShowRepo = tvShowRepo ?? GetIt.I<BaseTVShowRepository>(),
        super(TVShowsSectionsState.init());

  final BaseTVShowRepository _tvShowRepo;

  Future<void> loadTVShowSections() async {
    if (state.isBusy) return;

    emit(state.update(
      status: StateStatus.loading,
    ));

    try {
      final popularTVShows = await _tvShowRepo.getPopular();
      emit(state.update(
        popularTVShows: popularTVShows,
      ));

      final onTheAirTVShows = await _tvShowRepo.getOnTheAir();
      emit(state.update(
        status: StateStatus.loaded,
        onTheAirTVShows: onTheAirTVShows,
      ));
    } catch (error, stackTrace) {
      eh.catchIt(
        error: error,
        stackTrace: stackTrace,
        otherErrorMessage: "Something's wrong when loading movies sections :( Please try again",
        onCatch: _catchError,
      );
    }
  }

  void _catchError(String errorMessage) {
    emit(state.update(
      status: StateStatus.error,
      errorMessage: errorMessage,
    ));
  }
}
