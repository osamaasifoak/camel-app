part of '_home_screen.dart';

mixin _HomeScreenWidgets on _HomeScreenProps {
  List<Widget> get bottomNavPages => const <Widget>[
        MoviesSectionsScreen(),
        TVShowsSectionsScreen(),
        ProfileSectionScreen(),
      ];

  List<BottomNavigationBarItem> get bottomNavItems {
    return const <BottomNavigationBarItem>[
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
  }

  Widget get favIcon {
    return ValueListenableBuilder<int>(
      valueListenable: _bottomNavSelectedIndex,
      builder: (_, int index, Widget? child) {
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
      child: const SizedBox(key: ValueKey<int>(2)),
    );
  }

  late final Widget favMoviesIconButton = FavCountIcon(
    key: const ValueKey<int>(0),
    countStream: _favMoviesRepo.favCountController.stream,
    onTap: _loadFavorites,
  );

  late final Widget favTVShowsIconButton = FavCountIcon(
    key: const ValueKey<int>(1),
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
      builder: (_, int index, Widget? child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return AnimatedBuilder(
              animation: animation,
              builder: (_, Widget? child) => FadeTransition(
                opacity: animation,
                child: Transform.translate(
                  offset: Offset(0, (1 - animation.value) * 20),
                  child: child,
                ),
              ),
              child: child,
            );
          },
          child: index != 2
              ? child!
              : const Text(
                  'about Me',
                  key: ValueKey<String>('about-dev'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF01579B),
                  ),
                ),
        );
      },
      child: GestureDetector(
        key: const ValueKey<String>('app-name+search'),
        behavior: HitTestBehavior.opaque,
        onTap: onSearchTapped,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
        animatedTexts: <AnimatedText>[
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
