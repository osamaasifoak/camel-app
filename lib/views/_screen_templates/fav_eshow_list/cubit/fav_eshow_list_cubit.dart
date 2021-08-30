import 'package:bloc/bloc.dart';
import 'package:postor/error_handler.dart' as eh show catchIt;

import '/core/enums/state_status.dart';
import '/core/models/entertainment_show/entertainment_show.dart';
import '/views/_screen_templates/base_bloc_state.dart';

part 'fav_eshow_list_state.dart';

typedef LoadFavEShowIDsListCallback = Future<List<int>> Function({int page, int perPage});
typedef LoadEShowListByIDsCallback = Future<List<EShow>> Function(List<int> eShowIds);

class FavEShowListCubit extends Cubit<FavEShowListState> {
  FavEShowListCubit({
    required LoadFavEShowIDsListCallback loadFavEShowIDsListCallback,
    required LoadEShowListByIDsCallback loadEShowListByIDsCallback,
    required String unknownErrorMessage,
  })  : _loadFavEShowIDsListCallback = loadFavEShowIDsListCallback,
        _loadEShowListByIDsCallback = loadEShowListByIDsCallback,
        _unknownErrorMessage = unknownErrorMessage,
        super(FavEShowListState.init());

  final LoadFavEShowIDsListCallback _loadFavEShowIDsListCallback;
  final LoadEShowListByIDsCallback _loadEShowListByIDsCallback;
  final String _unknownErrorMessage;

  Future<void> loadFavEShows({bool more = false}) async {
    if (state.isBusy || (more && state.isAtEndOfPage)) return;

    emit(state.update(
      status: more ? StateStatus.loadingMore : StateStatus.loading,
      currentPage: more ? state.currentPage : 0,
    ));

    try {
      final int nextPage = more ? state.currentPage + 1 : 0;

      final List<int> localFavEShowIDs = await _loadFavEShowIDsListCallback(page: nextPage);
      if (localFavEShowIDs.isEmpty) {
        emit(state.update(
          status: StateStatus.loaded,
          isAtEndOfPage: true,
        ));
      } else {
        // we're gonna load the list half by half
        // because loading all at once, especially more than 5
        // takes a bit too long
        final int firstHalf = localFavEShowIDs.length ~/ 2;
        final int secondHalf = localFavEShowIDs.length;

        final List<EShow> firstHalfList = await _loadEShowListByIDsCallback(
          localFavEShowIDs.getRange(0, firstHalf).toList(growable: false),
        );
        emit(state.update(
          status: StateStatus.loadingMore,
          favEShows: more ? state.favEShows + firstHalfList : firstHalfList,
        ));

        final List<EShow> secondHalfList = await _loadEShowListByIDsCallback(
          localFavEShowIDs.getRange(firstHalf, secondHalf).toList(growable: false),
        );
        emit(state.update(
          status: StateStatus.loaded,
          favEShows: state.favEShows + secondHalfList,
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
    return emit(state.update(
      status: StateStatus.error,
      errorMessage: errorMessage,
    ));
  }
}
