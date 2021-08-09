part of '_movies_sections_screen.dart';

abstract class _MoviesSectionsProps extends State<MoviesSectionsScreen> with AutomaticKeepAliveClientMixin {
  final _moviesSectionsCubit = MoviesSectionsCubit();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _moviesSectionsCubit.loadMoviesSections();
  }

  @override
  void dispose() {
    _moviesSectionsCubit.close();
    super.dispose();
  }

  void _onMovieTapped(int movieId) {
    Navigator.of(context).pushNamed(
      AppRoutes.getMovieDetail(movieId),
    );
  }

  void _goToPopularMovieList() {
    Navigator.of(context).pushNamed(AppRoutes.popularMovieList);
  }

  void _goToNowPlayingMovieList() {
    Navigator.of(context).pushNamed(AppRoutes.nowPlayingMovieList);
  }

  void _goToUpcomingMovieList() {
    Navigator.of(context).pushNamed(AppRoutes.upcomingMovieList);
  }
}
