part of '_home_screen.dart';

mixin _HomeScreenWidgets on _HomeScreenProps {
  List<Widget> get moviePages => [
    BlocProvider(
      create: (_) => NowPlayingCubit(),
      child: NowPlayingScreen(scrollController: _nowPlayingScrollController),
    ),
    BlocProvider(
      create: (_) => UpcomingCubit(),
      child: UpcomingScreen(scrollController: _upcomingScrollController),
    ),
  ];

  List<BottomNavigationBarItem> get bottomNavItems => const [
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

  Widget get favIcon {
    return IconButton(
      iconSize: 27,
      padding: const EdgeInsets.all(4),
      icon: Stack(
        children: [
          const Icon(Icons.favorite_border),
          StreamBuilder<int>(
            initialData: 0,
            stream: _favMoviesRepo.favCountController.stream,
            builder: (_, countSnapshot) {
              return Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  constraints: const BoxConstraints(
                    minHeight: 12,
                    minWidth: 13,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    countSnapshot.data.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      color: Colors.grey[900],
      onPressed: _loadFavMovies,
    );
  }
}
