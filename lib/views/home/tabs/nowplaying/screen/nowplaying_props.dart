part of '_nowplaying_screen.dart';

abstract class _NowPlayingScreenProps extends State<NowPlayingScreen> with AutomaticKeepAliveClientMixin {
  final navigationService = GetIt.I<NavigationService>();
  // final nowPlayingMoviesListKey = PageStorageKey<int>(0);

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
    scrollController.dispose();
    super.dispose();
  }
}