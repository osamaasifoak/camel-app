part of '_home_screen.dart';

abstract class _HomeScreenProps extends State<HomeScreen> with SingleTickerProviderStateMixin {
  
  late final TabController tabController;
  // late final NowPlayingMoviesBloc nowPlayingMoviesBloc;
  // late final UpcomingMoviesBloc upcomingMoviesBloc;
  late final FavMoviesCubit favMoviesCubit;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    // nowPlayingMoviesBloc = context.read<NowPlayingMoviesBloc>();
    // upcomingMoviesBloc = context.read<UpcomingMoviesBloc>();
    favMoviesCubit = context.read<FavMoviesCubit>();
    // nowPlayingMoviesBloc.add(NowPlayingMoviesLoading());
  }

  // void tabBarTapped(int value) {
  //   if (value == 1 && upcomingMoviesBloc.state.status == MoviesStatus.init)
  //     upcomingMoviesBloc.add(UpcomingMoviesLoading());
  //   else if (value == 0)
  //     nowPlayingMoviesBloc.add(NowPlayingMoviesScrollToTopRequested());
  //   else if (value == 1)
  //     upcomingMoviesBloc.add(UpcomingMoviesScrollToTopRequested());
  // }

  void loadFavMovies() {
    favMoviesCubit.loadFavMovies();
    Navigator.of(context).pushNamed(AppRoutes.favMovies);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}