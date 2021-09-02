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
      builder: (_, index, child) {
        final Widget nextIcon;
        switch (index) {
          case 0:
            nextIcon = favMoviesIconButton;
            break;
          case 1:
            nextIcon = favTVShowsIconButton;
            break;
          default:
            nextIcon = child!;
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: nextIcon,
        );
      },
      child: const SizedBox(key: ValueKey(2)),
    );
  }

  late final Widget favMoviesIconButton = FavCountIcon(
    key: const ValueKey(0),
    countStream: _favMoviesRepo.favCountController.stream,
    onTap: _loadFavorites,
  );

  late final Widget favTVShowsIconButton = FavCountIcon(
    key: const ValueKey(1),
    countStream: _favTVShowsRepo.favCountController.stream,
    onTap: _loadFavorites,
  );
}

class _AnimatedHomeScreenTitle extends StatelessWidget {
  const _AnimatedHomeScreenTitle({
    Key? key,
    required this.bottomNavSelectedIndex,
    required this.onSearchTapped,
  }) : super(key: key);

  final ValueNotifier<int> bottomNavSelectedIndex;
  final VoidCallback onSearchTapped;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: bottomNavSelectedIndex,
      builder: (_, index, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) => AnimatedBuilder(
            animation: animation,
            builder: (_, child) => FadeTransition(
              opacity: animation,
              child: Transform.translate(
                offset: Offset(0, (1 - animation.value) * 20),
                child: child,
              ),
            ),
            child: child,
          ),
          child: index != 2
              ? child!
              : const Text(
                  'about Me',
                  key: ValueKey('about-dev'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF01579B),
                  ),
                ),
        );
      },
      child: GestureDetector(
        key: const ValueKey('app-name+search'),
        behavior: HitTestBehavior.opaque,
        onTap: onSearchTapped,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _AnimatedAppNameTitle(onTap: onSearchTapped),
              const SizedBox(width: 5),
              const Icon(
                Icons.search_rounded,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedAppNameTitle extends StatelessWidget {
  const _AnimatedAppNameTitle({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(
        color: Color(0xFF01579B),
        fontWeight: FontWeight.bold,
      ),
      child: AnimatedTextKit(
        pause: const Duration(milliseconds: 1500),
        totalRepeatCount: 1,
        onTap: onTap,
        animatedTexts: [
          TyperAnimatedText(
            'caMel',
            curve: Curves.ease,
            speed: const Duration(milliseconds: 100),
          ),
          TyperAnimatedText(
            'moVies',
            curve: Curves.ease,
            speed: const Duration(milliseconds: 100),
          ),
          TyperAnimatedText(
            'tvShows',
            curve: Curves.ease,
            speed: const Duration(milliseconds: 100),
          ),
          TyperAnimatedText(
            'discover Now',
            curve: Curves.ease,
            speed: const Duration(milliseconds: 100),
          ),
        ],
      ),
    );
  }
}
