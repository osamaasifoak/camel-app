part of '_home_screen.dart';

mixin _HomeScreenWidgets on _HomeScreenProps {
  List<Widget> get bottomNavPages => const [
        MoviesSectionsScreen(),
        TVShowsSectionsScreen(),
        ProfileSectionScreen(),
      ];

  List<BottomNavigationBarItem> get bottomNavItems => const [
        BottomNavigationBarItem(
          icon: Icon(Icons.smart_display_outlined),
          activeIcon: Icon(Icons.smart_display),
          label: 'Movies',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.upcoming_outlined),
          activeIcon: Icon(Icons.upcoming),
          label: 'TV Shows',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          activeIcon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ];

  Widget get favIcon {
    return ValueListenableBuilder<int>(
      valueListenable: _bottomNavSelectedIndex,
      builder: (_, index, __) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            );
          },
          child: index == 0
              ? favMoviesIconButton
              : index == 1
                  ? favTVShowsIconButton
                  : const SizedBox(key: ValueKey(2)),
        );
      },
    );
  }

  Widget get favMoviesIconButton {
    return IconButton(
      key: const ValueKey(0),
      onPressed: _loadFavorites,
      color: Colors.grey[900],
      iconSize: 27,
      padding: const EdgeInsets.all(4),
      icon: Stack(
        children: [
          const Icon(Icons.favorite_border),
          StreamBuilder<int>(
            key: const ValueKey(0),
            initialData: 0,
            stream: _favMoviesRepo.favCountController.stream,
            builder: (_, countSnapshot) {
              return favIconCount(countSnapshot.data);
            },
          ),
        ],
      ),
    );
  }

  Widget get favTVShowsIconButton {
    return IconButton(
      key: const ValueKey(1),
      onPressed: _loadFavorites,
      color: Colors.grey[900],
      iconSize: 27,
      padding: const EdgeInsets.all(4),
      icon: Stack(
        children: [
          const Icon(Icons.favorite_border),
          StreamBuilder<int>(
            key: const ValueKey(1),
            initialData: 0,
            stream: _favTVShowsRepo.favTVCountController.stream,
            builder: (_, countSnapshot) {
              return favIconCount(countSnapshot.data);
            },
          ),
        ],
      ),
    );
  }

  Widget favIconCount(int? count) {
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
          count?.toString() ?? '0',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
