import 'package:get_it/get_it.dart';

import '/core/enums/state_status.dart';
import '/core/helpers/error_handler.dart';
import '/core/models/tv_show/tv_show.dart';
import '/core/repositories/tv_show_repo/base_tv_show_repo.dart';
import '/views/_screen_templates/tv_show/base_tv_show_list_cubit/base_tv_show_list_cubit.dart';

part 'populartvshow_state.dart';

class PopularTVShowCubit extends BaseTVShowListCubit<PopularTVShowState> {
  PopularTVShowCubit({
    BaseTVShowRepository? tvShowRepo,
  })  : _tvShowRepo = tvShowRepo ?? GetIt.I<BaseTVShowRepository>(),
        super(PopularTVShowState.init());

  final BaseTVShowRepository _tvShowRepo;

  @override
  Future<void> loadTVShows({bool more = false}) async {
    if (state.isBusy) return;

    emit(state.update(
      status: more ? StateStatus.loadingMore : StateStatus.loading,
      page: more ? state.page : 1,
    ));

    try {
      final nextPage = more ? state.page + 1 : 1;
      final tvShows = await _tvShowRepo.getPopular(page: nextPage);

      emit(state.update(
        tvShows: state.tvShows + tvShows,
        status: StateStatus.loaded,
        page: nextPage,
      ));
    } catch (e, st) {
      ErrorHandler.catchIt(
        error: e,
        stackTrace: st,
        customUnknownErrorMessage: 'Failed to fetch popular TV shows. Please try again.',
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
