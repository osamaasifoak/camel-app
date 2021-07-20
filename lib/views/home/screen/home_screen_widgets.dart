part of '_home_screen.dart';

mixin _HomeScreenWidgets on _HomeScreenProps {
  
  List<Widget> moviePages() => [ 
    NowPlayingScreen(scrollController: nowPlayingScrollController), 
    UpcomingScreen(scrollController: upcomingScrollController),
  ];

  List<BottomNavigationBarItem> bottomNavItems() => const [
    BottomNavigationBarItem(
      icon: Icon(Icons.smart_display_outlined),
      activeIcon: Icon(Icons.smart_display),
      label: 'Now Playing',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.upcoming_outlined),
      activeIcon: Icon(Icons.upcoming),
      label: 'Upcoming',
    ),
  ];

  Widget favIcon() {
    return IconButton(
      icon: const Icon(Icons.favorite_border),
      color: Colors.grey[900],
      onPressed: _loadFavMovies,
    );
  }
}