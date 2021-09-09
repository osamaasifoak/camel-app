part of '_search_screen.dart';

abstract class _SearchScreenProps extends State<SearchScreen> {
  final ScrollController _searchListScrollController = ScrollController();
  late final SearchEShowBloc _searchBloc = widget.searchBloc ?? SearchEShowBloc();

  @override
  void initState() {
    super.initState();
    _refresh();
    _searchListScrollController.addListener(_tryLoadMore);
  }

  @override
  void dispose() {
    _searchListScrollController.dispose();
    // if [_searchBloc] was provided by [widget.searchBloc] then
    // it's not this widget's responsibility to close it
    if (widget.searchBloc == null) _searchBloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    if (_searchBloc.state.isBusy) {
      return;
    }
    _searchBloc.add(RefreshEShowEvent());
    await for (final SearchEShowState nextState in _searchBloc.stream) {
      if (!nextState.isLoading) {
        break;
      }
    }
  }

  void _tryLoadMore() {
    if (!_searchListScrollController.hasClients) return;

    // when user scrolls to the bottom of the list, load more eshow list.
    if (_searchListScrollController.offset >= _searchListScrollController.position.maxScrollExtent - 80 &&
        _searchListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
        !_searchBloc.state.isBusy &&
        !_searchBloc.state.isAtEndOfPage) {
      _searchBloc.add(LoadMoreEShowEvent());
    }
  }

  void _onEShowTapped(final int eShowId) {
    if (_searchBloc.state.currentSelectedEShow == EShowType.movie) {
      Navigator.of(context).pushNamed(
        AppRoutes.getMovieDetail(eShowId),
        arguments: context,
      );
    } else {
      Navigator.of(context).pushNamed(
        AppRoutes.getTVShowDetail(eShowId),
        arguments: context,
      );
    }
  }

  bool _onBackPressed() {
    if (_searchListScrollController.offset > 100 && !kIsWeb) {
      _scrollSearchList();
      return false;
    }
    return true;
  }

  void _scrollSearchList() {
    _searchListScrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }
}
