part of '_nowplaying_screen.dart';

abstract class _NowPlayingScreenProps extends State<NowPlayingScreen> with AutomaticKeepAliveClientMixin {
  final _navigationService = GetIt.I<BaseNavigationService>();

  late final ScrollController _scrollController;
  late final NowPlayingCubit _nowPlayingCubit;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _nowPlayingCubit = context.read<NowPlayingCubit>();
    _scrollController = widget.scrollController ?? ScrollController()
      ..addListener(() {
        /// when user scrolls to the bottom of the list, load more movies.
        if (
            _scrollController.offset >= _scrollController.position.maxScrollExtent - 80 &&
            _scrollController.position.userScrollDirection == ScrollDirection.reverse &&
            _nowPlayingCubit.state.status != NowPlayingStatus.loadingMore &&
            _nowPlayingCubit.state.status != NowPlayingStatus.loading

            ) {

          _nowPlayingCubit.loadMovies(more: true);

        }

      });
    _nowPlayingCubit.loadMovies();
  }

  @override
  void dispose() {
    /// if widget.screenController is null, it means the ScreenController was created by this screen
    /// and needed to be disposed. Otherwise it's not this screen's responsibility to dispose it.
    if(widget.scrollController == null) _scrollController.dispose();
    super.dispose();
  }
}