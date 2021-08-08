part of '_favmovies_screen.dart';

abstract class _FavMoviesScreenProps extends State<FavMoviesScreen> {

  final _favMoviesCubit = FavMoviesCubit();
  final _favMoviesScrollController = ScrollController();

  @override
  void initState() { 
    super.initState();
    _favMoviesScrollController.addListener(_loadMoreFavMovies);
    _favMoviesCubit.loadFavMovies();
  }

  @override
  void dispose() { 
    _favMoviesCubit.close();
    _favMoviesScrollController.dispose();
    super.dispose();
  }

  void _loadMoreFavMovies() {
    // don't execute when scroll controller has no clients (scrollviews)
    if(!_favMoviesScrollController.hasClients) return;
    // when user scrolls to the bottom of the list, load more fav movies.
    if (_favMoviesScrollController.offset >= _favMoviesScrollController.position.maxScrollExtent - 80 &&
        _favMoviesScrollController.position.userScrollDirection == ScrollDirection.reverse &&
        !_favMoviesCubit.state.isBusy && !_favMoviesCubit.state.isAtEndOfPage
        ) {
      _favMoviesCubit.loadFavMovies(more: true);
    }
  }
}