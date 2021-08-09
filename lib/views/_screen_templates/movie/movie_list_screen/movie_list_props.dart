part of '_movie_list_screen.dart';

abstract class _MovieListScreenProps<B extends BMLC<S>, S extends BMLS> extends State<MovieListScreen> {

  late final ScrollController _movieListScrollController;
  late final B _baseMovieListCubit;

  @override
  void initState() {
    super.initState();
    _baseMovieListCubit = context.read<B>();
    _movieListScrollController = widget.scrollController ?? ScrollController()
      ..addListener(_loadMoreMovies);
    _baseMovieListCubit.loadMovies();
  }

  @override
  void dispose() {
    // if widget.screenController is null, it means the ScreenController was created by this screen
    // and needed to be disposed. Otherwise it's not this screen's responsibility to dispose it.
    if(widget.scrollController == null) _movieListScrollController.dispose();
    if(widget.closeCubitOnDispose) _baseMovieListCubit.close();
    super.dispose();
  }

  void _loadMoreMovies() {
    // when user scrolls to the bottom of the list, load more movies.
    if (_movieListScrollController.offset >= _movieListScrollController.position.maxScrollExtent - 80 &&
        _movieListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
        !_baseMovieListCubit.state.isBusy) {
      _baseMovieListCubit.loadMovies(more: true);
    }
  }
}