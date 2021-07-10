part of '_home_screen.dart';

abstract class _HomeScreenProps extends State<HomeScreen> with SingleTickerProviderStateMixin {
  
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);
  
  final ScrollController nowPlayingScrollController = ScrollController();
  final ScrollController upcomingScrollController = ScrollController();
  
  late final PageController pageController;
  late final FavMoviesCubit favMoviesCubit;

  @override
  void initState() {
    super.initState();
    favMoviesCubit = context.read<FavMoviesCubit>();
    pageController = PageController();
  }

  @override
  void dispose() { 
    selectedIndex.dispose();
    nowPlayingScrollController.dispose();
    upcomingScrollController.dispose();
    pageController.dispose();
    favMoviesCubit.close();

    super.dispose();
  }

  void loadFavMovies() {
    favMoviesCubit.loadFavMovies();
    Navigator.of(context).pushNamed(AppRoutes.favMovies);
  }

  void _scrollNowPlaying() {
    nowPlayingScrollController.animateTo(
      0.0, 
      duration: Duration(milliseconds: 500), 
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void _scrollUpcoming() {
    upcomingScrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void onBottomNavTapped(int index) {

    if(selectedIndex.value == index) {

      if(index == 0 && nowPlayingScrollController.offset > 0.0) {
        
        _scrollNowPlaying();

      }else if(index == 1 && upcomingScrollController.offset > 0.0) {

        _scrollUpcoming();

      }

      return;
    }

    selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

}