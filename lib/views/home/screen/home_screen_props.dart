part of '_home_screen.dart';

abstract class _HomeScreenProps extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final _bottomNavSelectedIndex = ValueNotifier(0);

  final _favMoviesRepo = GetIt.I<BaseFavMoviesRepository>();
  final _favTVShowsRepo = GetIt.I<BaseFavTVShowsRepository>();

  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _favMoviesRepo.refreshFavMoviesCount();
    _favTVShowsRepo.refreshFavTVShowsCount();
  }

  @override
  void dispose() {
    _bottomNavSelectedIndex.dispose();
    _pageController.dispose();
    _favMoviesRepo.close();

    GetIt.I<BaseNetworkService>().close();
    GetIt.I<BaseLocalDbService>().closeDb();

    super.dispose();
  }

  // ignore: use_setters_to_change_properties
  void _onPageChanged(int index) {
    _bottomNavSelectedIndex.value = index;
  }

  void _loadFavorites() {
    if(_bottomNavSelectedIndex.value == 0) {
      Navigator.of(context).pushNamed(AppRoutes.favMovies);
    } else if(_bottomNavSelectedIndex.value == 1) {
      Navigator.of(context).pushNamed(AppRoutes.favTVShows);
    }
  }

  void _onBottomNavTapped(int index) {
    if (_bottomNavSelectedIndex.value != index) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    }
  }
}
