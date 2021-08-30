part of '_fav_eshow_list_screen.dart';

abstract class _FavEShowListProps extends State<FavEShowListScreen> {

  final ScrollController _favEShowListController = ScrollController();
  late final FavEShowListCubit _currentFavEShowListCubit = context.read<FavEShowListCubit>();

  @override
  void initState() { 
    super.initState();
    _favEShowListController.addListener(_tryLoadMoreFavEShows);
    _currentFavEShowListCubit.loadFavEShows();
  }

  @override
  void dispose() { 
    _favEShowListController.dispose();
    super.dispose();
  }
  
  Future<void> _onFavEShowTapped(final int movieId) async {
    await widget.onEShowTapped(context, movieId);
    if(mounted) {
      _currentFavEShowListCubit.loadFavEShows();
    }
  }

  void _tryLoadMoreFavEShows() {
    // don't execute when scroll controller has no clients (scrollviews)
    if(!_favEShowListController.hasClients) return;
    // when user scrolls to the bottom of the list, load more favorites.
    if (_favEShowListController.offset >= _favEShowListController.position.maxScrollExtent - 80 
        && _favEShowListController.position.userScrollDirection == ScrollDirection.reverse 
        && _currentFavEShowListCubit.state.isNotBusy 
        && _currentFavEShowListCubit.state.isNotAtEndOfPage
        ) {
      _currentFavEShowListCubit.loadFavEShows(more: true);
    }
  }

}