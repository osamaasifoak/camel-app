part of '_home_screen.dart';

abstract class _HomeScreenProps extends State<HomeScreen> with SingleTickerProviderStateMixin {
  
  final _selectedIndex = ValueNotifier(0);
  
  final _nowPlayingScrollController = ScrollController();
  final _upcomingScrollController = ScrollController();
  
  final _favMoviesRepo = GetIt.I<BaseFavMoviesRepository>();

  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _favMoviesRepo.getFavCount().then(_favMoviesRepo.favCountController.add);
  }

  @override
  void dispose() { 
    _selectedIndex.dispose();
    _nowPlayingScrollController.dispose();
    _upcomingScrollController.dispose();
    _pageController.dispose();
    _favMoviesRepo.close();

    GetIt.I<BaseNetworkService>().close();
    GetIt.I<BaseLocalDbService>().closeDb();

    super.dispose();
  }

  void _loadFavMovies() async {
    Navigator.of(context).pushNamed(AppRoutes.favMovies);
  }

  void _scrollNowPlaying() {
    _nowPlayingScrollController.animateTo(
      0.0, 
      duration: Duration(milliseconds: 500), 
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void _scrollUpcoming() {
    _upcomingScrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void _onBottomNavTapped(int index) {

    if(_selectedIndex.value == index) {

      if(index == 0 && _nowPlayingScrollController.offset > 0.0) {
        
        _scrollNowPlaying();

      }else if(index == 1 && _upcomingScrollController.offset > 0.0) {

        _scrollUpcoming();

      }

      return;
    }

    _selectedIndex.value = index;
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

}