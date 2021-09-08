import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:postor/error_handler.dart' as eh show catchIt;

import '/core/enums/state_status.dart';
import '/core/models/entertainment_show/entertainment_show.dart';
import '/core/repositories/base_eshows_repo.dart';
import '/views/_screen_templates/base_bloc_state.dart';

part 'eshow_list_state.dart';

class EShowListCubit extends Cubit<EShowListState> {
  EShowListCubit({
    required String category,
    required BaseEShowsRepository eShowsRepo,
    required String unknownErrorMessage,
  })  : _category = category,
        _eShowsRepo = eShowsRepo,
        _unknownErrorMessage = unknownErrorMessage,
        super(EShowListState.init());

  final String _category;
  final BaseEShowsRepository _eShowsRepo;
  final String _unknownErrorMessage;

  Future<void> loadEShows({bool more = false}) async {
    if (state.isBusy || (more && state.isAtEndOfPage)) return;

    emit(
      state.update(
        status: more ? StateStatus.loadingMore : StateStatus.loading,
        currentPage: more ? state.currentPage : 1,
      ),
    );

    try {
      final int nextPage = more ? state.currentPage + 1 : 1;
      final List<EShow> eShows = await _eShowsRepo.fetch(
        category: _category,
        page: nextPage,
      );

      if (eShows.isEmpty) {
        emit(
          state.update(
            status: StateStatus.loaded,
            isAtEndOfPage: true,
          ),
        );
      } else {
        emit(
          state.update(
            eShows: more ? state.eShows + eShows : eShows,
            status: StateStatus.loaded,
            currentPage: nextPage,
          ),
        );
      }
    } catch (e, st) {
      eh.catchIt(
        error: e,
        stackTrace: st,
        otherErrorMessage: _unknownErrorMessage,
        onCatch: _catchError,
      );
    }
  }

  void _catchError(String errorMessage) {
    emit(
      state.update(
        status: StateStatus.error,
        errorMessage: errorMessage,
      ),
    );
  }
}
