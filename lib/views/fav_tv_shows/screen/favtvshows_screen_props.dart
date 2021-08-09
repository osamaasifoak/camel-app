part of '_favtvshows_screen.dart';

abstract class _FavTVShowsScreenProps extends State<FavTVShowsScreen> {
  final _favTVShowsCubit = FavTVShowsCubit();
  final _favTVShowsScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _favTVShowsScrollController.addListener(_loadMoreFavTVShows);
    _favTVShowsCubit.loadFavTVShows();
  }

  @override
  void dispose() {
    _favTVShowsCubit.close();
    _favTVShowsScrollController.dispose();
    super.dispose();
  }

  Future<void> _onTVShowTapped(int tvShowId) async {
    await Navigator.of(context).pushNamed(
      AppRoutes.getTVShowDetail(tvShowId),
    );
    _favTVShowsCubit.loadFavTVShows();
  }

  void _loadMoreFavTVShows() {
    // don't execute when scroll controller has no clients (scrollviews)
    if (!_favTVShowsScrollController.hasClients) return;
    // when user scrolls to the bottom of the list, load more fav tv shows.
    if (_favTVShowsScrollController.offset >= _favTVShowsScrollController.position.maxScrollExtent - 80 &&
        _favTVShowsScrollController.position.userScrollDirection == ScrollDirection.reverse &&
        !_favTVShowsCubit.state.isBusy &&
        !_favTVShowsCubit.state.isAtEndOfPage) {
      _favTVShowsCubit.loadFavTVShows(more: true);
    }
  }
}
