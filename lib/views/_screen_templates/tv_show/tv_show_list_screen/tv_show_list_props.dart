part of '_tv_show_list_screen.dart';

abstract class _TVShowListScreenProps<B extends BTVSLC<S>, S extends BTVSLS> extends State<TVShowListScreen> {

  late final ScrollController _movieListScrollController;
  late final B _baseTVShowListCubit;

  @override
  void initState() {
    super.initState();
    _baseTVShowListCubit = context.read<B>();
    _movieListScrollController = widget.scrollController ?? ScrollController()
      ..addListener(_loadMoreTVShows);
    _baseTVShowListCubit.loadTVShows();
  }

  @override
  void dispose() {
    // if widget.screenController is null, it means the ScreenController was created by this screen
    // and needed to be disposed. Otherwise it's not this screen's responsibility to dispose it.
    if(widget.scrollController == null) _movieListScrollController.dispose();
    if(widget.closeCubitOnDispose) _baseTVShowListCubit.close();
    super.dispose();
  }

  void _loadMoreTVShows() {
    // when user scrolls to the bottom of the list, load more movies.
    if (_movieListScrollController.offset >= _movieListScrollController.position.maxScrollExtent - 80 &&
        _movieListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
        !_baseTVShowListCubit.state.isBusy) {
      _baseTVShowListCubit.loadTVShows(more: true);
    }
  }
}