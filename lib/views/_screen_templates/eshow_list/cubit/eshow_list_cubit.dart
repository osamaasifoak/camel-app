import 'package:bloc/bloc.dart';
import 'package:postor/error_handler.dart' as eh show catchIt;

import '/core/enums/state_status.dart';
import '/core/models/entertainment_show/entertainment_show.dart';
import '/views/_screen_templates/base_bloc_state.dart';

part 'eshow_list_state.dart';

typedef LoadEShowCallback = Future<List<EShow>> Function({int page});

class EShowListCubit extends Cubit<EShowListState> {
  EShowListCubit({
    required LoadEShowCallback loadEShowCallback,
    required String unknownErrorMessage,
  })  : _loadEShowCallback = loadEShowCallback,
        _unknownErrorMessage = unknownErrorMessage,
        super(EShowListState.init());

  final LoadEShowCallback _loadEShowCallback;
  final String _unknownErrorMessage;

  Future<void> loadEShows({bool more = false}) async {
    if (state.isBusy || (more && state.isAtEndOfPage)) return;

    emit(state.update(
      status: more ? StateStatus.loadingMore : StateStatus.loading,
      currentPage: more ? state.currentPage : 1,
    ));

    try {
      final int nextPage = more ? state.currentPage + 1 : 1;
      final List<EShow> eShows = await _loadEShowCallback(page: nextPage);

      if (eShows.isEmpty) {
        emit(state.update(
          status: StateStatus.loaded,
          isAtEndOfPage: true,
        ));
      } else {
        emit(state.update(
          eShows: more ? state.eShows + eShows : eShows,
          status: StateStatus.loaded,
          currentPage: nextPage,
        ));
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
    emit(state.update(
      status: StateStatus.error,
      errorMessage: errorMessage,
    ));
  }
}
