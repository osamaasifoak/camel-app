import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:postor/postor.dart' show CancelledRequestException;
import 'package:postor/error_handler.dart' as eh show catchIt;
import 'package:rxdart/streams.dart' show MergeExtension;
import 'package:rxdart/transformers.dart' show DebounceExtensions, SwitchMapExtension;

import '/core/enums/state_status.dart';
import '/core/models/entertainment_show/entertainment_show.dart';
import '/core/repositories/movies_repo/base_movies_repo.dart';
import '/core/repositories/tv_show_repo/base_tv_show_repo.dart';

part 'search_eshow_event.dart';
part 'search_eshow_state.dart';

typedef SearchState = Stream<SearchEShowState>;
typedef SearchEvent = Stream<SearchEShowEvent>;
typedef SearchTransition = Stream<Transition<SearchEShowEvent, SearchEShowState>>;
typedef SearchTransitionFn = TransitionFunction<SearchEShowEvent, SearchEShowState>;

class SearchEShowBloc extends Bloc<SearchEShowEvent, SearchEShowState> {
  SearchEShowBloc({
    BaseMoviesRepository? moviesRepo,
    BaseTVShowRepository? tvShowRepo,
  })  : _moviesRepo = moviesRepo ?? GetIt.I<BaseMoviesRepository>(),
        _tvShowRepo = tvShowRepo ?? GetIt.I<BaseTVShowRepository>(),
        super(SearchEShowState.init());

  final BaseMoviesRepository _moviesRepo;
  final BaseTVShowRepository _tvShowRepo;

  @override
  SearchTransition transformEvents(
    SearchEvent events,
    SearchTransitionFn transitionFn,
  ) {
    final nonDebounceEvents = events.where(
      (event) => event is! SearchKeywordChangedEvent,
    );
    final debounceEvents = events
        .where(
          (event) => event is SearchKeywordChangedEvent,
        )
        .debounceTime(
          const Duration(milliseconds: 185),
        );

    return nonDebounceEvents.mergeWith([debounceEvents]).switchMap(transitionFn);
  }

  @override
  SearchState mapEventToState(
    SearchEShowEvent event,
  ) async* {
    if (event is SearchKeywordChangedEvent) {
      yield* _searchKeywordChanged(searchKeyword: event.searchKeyword);
    } else if (event is SelectedEShowChangedEvent) {
      yield* _selectedEShowChanged(newSelectedEShow: event.newSelectedEShow);
    } else if (event is RefreshEShowEvent) {
      yield* _refresh();
    } else if (event is LoadMoreEShowEvent) {
      yield* _loadMore();
    }
  }

  void _cancelLastSearchIfBusy() {
    if (state.isBusy) {
      if (state.currentSelectedEShow == EShowType.movie) {
        _moviesRepo.cancelLastMovieSearch();
      } else {
        _tvShowRepo.cancelLastTVShowSearch();
      }
    }
  }

  Future<List<EShow>> _loadEShowList({int? page}) async {
    if (state.searchKeyword.isEmpty) {
      return const <EShow>[];
    }
    if (state.currentSelectedEShow == EShowType.movie) {
      return _moviesRepo.searchMovie(
        keyword: state.searchKeyword,
        page: page ?? state.page,
      );
    }
    return _tvShowRepo.searchTVShow(
      keyword: state.searchKeyword,
      page: page ?? state.page,
    );
  }

  SearchState _searchKeywordChanged({required String searchKeyword}) async* {
    _cancelLastSearchIfBusy();

    yield state.update(
      status: StateStatus.loading,
      searchKeyword: searchKeyword,
    );
    yield* _reloadSearch(nextPage: 1);
  }

  SearchState _selectedEShowChanged({required EShowType newSelectedEShow}) async* {
    if (state.currentSelectedEShow == newSelectedEShow) {
      return;
    }

    _cancelLastSearchIfBusy();

    yield state.update(
      status: StateStatus.loading,
      eShowList: const [],
      currentSelectedEShow: newSelectedEShow,
      page: 1,
    );
    yield* _reloadSearch();
  }

  SearchState _refresh() async* {
    if (state.isBusy) {
      return;
    }

    yield state.update(status: StateStatus.loading);
    yield* _reloadSearch(nextPage: 1);
  }

  SearchState _loadMore() async* {
    if (state.isBusy || state.isAtEndOfPage) {
      return;
    }
    yield state.update(status: StateStatus.loadingMore);
    try {
      final nextPage = state.page + 1;
      final eShowList = await _loadEShowList(page: nextPage);
      if (eShowList.isNotEmpty) {
        yield state.update(
          status: StateStatus.loaded,
          eShowList: state.eShowList + eShowList,
          page: nextPage,
        );
      } else {
        yield state.update(
          status: StateStatus.loaded,
          isAtEndOfPage: true,
        );
      }
    } catch (error, stackTrace) {
      if (error is! CancelledRequestException) {
        yield* eh.catchIt(
          error: error,
          stackTrace: stackTrace,
          onCatch: _searchError,
        );
      }
    }
  }

  /// this is a pure state yielder without any additional
  /// mechanism before loading the list.
  /// so this is different than [_refresh]
  SearchState _reloadSearch({int? nextPage}) async* {
    try {
      final eShowList = await _loadEShowList();
      yield state.update(
        status: StateStatus.loaded,
        eShowList: eShowList,
        page: nextPage,
      );
    } catch (error, stackTrace) {
      if (error is! CancelledRequestException) {
        yield* eh.catchIt(
          error: error,
          stackTrace: stackTrace,
          onCatch: _searchError,
        );
      }
    }
  }

  SearchState _searchError(String errorMessage) async* {
    yield state.update(
      status: StateStatus.error,
      errorMessage: errorMessage,
    );
  }

  @override
  Future<void> close() {
    _moviesRepo.cancelLastMovieSearch();
    _tvShowRepo.cancelLastTVShowSearch();
    return super.close();
  }
}
