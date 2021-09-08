part of '_home_screen.dart';

abstract class _HomeScreenProps extends State<HomeScreen> {
  final ValueNotifier<int> _bottomNavSelectedIndex = ValueNotifier<int>(0);

  final BaseFavEShowsRepository _favMoviesRepo =
      GetIt.I<BaseFavEShowsRepository>(instanceName: SIName.repo.favMovies);
  final BaseFavEShowsRepository _favTVShowsRepo =
      GetIt.I<BaseFavEShowsRepository>(instanceName: SIName.repo.favTVShows);

  final PageController _pageController = PageController();

  void _goToSearchScreen() {
    Navigator.of(context).pushNamed(AppRoutes.searchShows);
  }

  // ignore: use_setters_to_change_properties
  void _onPageChanged(int index) {
    _bottomNavSelectedIndex.value = index;
  }

  void _loadFavorites() {
    if (_bottomNavSelectedIndex.value == 0) {
      Navigator.of(context).pushNamed(AppRoutes.favMovies);
    } else if (_bottomNavSelectedIndex.value == 1) {
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
