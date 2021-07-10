part of '_nowplaying_screen.dart';

abstract class _NowPlayingScreenProps extends State<NowPlayingScreen> with AutomaticKeepAliveClientMixin {
  final navigationService = GetIt.I<NavigationService>();

  late final ScrollController scrollController;
  late final NowPlayingCubit nowPlayingCubit;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    nowPlayingCubit = context.read<NowPlayingCubit>();
    scrollController = widget.scrollController ?? ScrollController()
      ..addListener(() {
        /// when user scrolls to the bottom of the list, load more movies.
        if (
            scrollController.offset >= scrollController.position.maxScrollExtent - 80 &&
            scrollController.position.userScrollDirection == ScrollDirection.reverse &&
            nowPlayingCubit.state.status != NowPlayingStatus.loadingMore &&
            nowPlayingCubit.state.status != NowPlayingStatus.loading

            ) {

          nowPlayingCubit.loadMovies(more: true);

        }

      });
    nowPlayingCubit.loadMovies();
  }

  @override
  void dispose() {
    /// if widget.screenController is null, it means the ScreenController was created by this screen
    /// and needed to be disposed. Otherwise it's not this screen's responsibility to dispose it.
    if(widget.scrollController == null) scrollController.dispose();
    super.dispose();
  }
}