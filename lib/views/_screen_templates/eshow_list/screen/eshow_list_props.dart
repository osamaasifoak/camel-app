part of '_eshow_list_screen.dart';

abstract class _EShowListScreenProps extends State<EShowListScreen> {

  late final EShowListCubit _currentEShowListCubit = context.read<EShowListCubit>();
  late final ScrollController _eShowListController = widget.scrollController ?? ScrollController();

  @override
  void initState() {
    super.initState();
    _eShowListController.addListener(_loadMoreMovies);
    _currentEShowListCubit.loadEShows();
  }

  @override
  void dispose() {
    // if widget.screenController is null, it means the ScreenController was created by this screen
    // and needed to be disposed. Otherwise it's not this screen's responsibility to dispose it.
    if(widget.scrollController == null) _eShowListController.dispose();
    super.dispose();
  }

  void _loadMoreMovies() {
    if(!_eShowListController.hasClients) return;
    // when user scrolls to the bottom of the list, load more movies.
    if (_eShowListController.offset >= _eShowListController.position.maxScrollExtent - 80 
        && _eShowListController.position.userScrollDirection == ScrollDirection.reverse 
        && _currentEShowListCubit.state.isNotBusy 
        && _currentEShowListCubit.state.isNotAtEndOfPage) {
      _currentEShowListCubit.loadEShows(more: true);
    }
  }
}