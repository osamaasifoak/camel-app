import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_routes.dart';
import '/core/repositories/fav_tv_shows_repo/base_fav_tv_shows_repo.dart';
import '/core/repositories/favmovies_repo/base_favmovies_repo.dart';
import '/core/services/localdb_service/base_localdb_service.dart';
import '/core/services/network_service/base_network_service.dart';
import '/views/home/tabs/movies_sections/screen/_movies_sections_screen.dart';
import '/views/home/tabs/profile/profile_screen.dart';
import '/views/home/tabs/tv_shows_sections/screen/_tvshows_sections_screen.dart';

part 'home_screen_props.dart';
part 'home_screen_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends _HomeScreenProps with _HomeScreenWidgets {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<int>(
          valueListenable: _bottomNavSelectedIndex,
          builder: (_, index, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (_, child) {
                    return Opacity(
                      opacity: animation.value,
                      child: Transform.translate(
                        offset: Offset(0, (1.0 - animation.value) * 20),
                        child: child,
                      ),
                    );
                  },
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
              child: index != 2
                  ? child!
                  : const Text(
                      'about Me',
                      key: ValueKey('about-dev'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF01579B),
                      ),
                    ),
            );
          },
          child: const Text(
            'caMel',
            key: ValueKey('app-name'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF01579B),
            ),
          ),
        ),
        actions: [
          favIcon,
        ],
        centerTitle: true,
        elevation: 10.0,
        shadowColor: Colors.white24,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        allowImplicitScrolling: true,
        children: bottomNavPages,
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _bottomNavSelectedIndex,
        builder: (_, index, __) => BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: index,
          onTap: _onBottomNavTapped,
          selectedItemColor: const Color(0xFF01579B),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          showUnselectedLabels: true,
          items: bottomNavItems,
        ),
      ),
    );
  }
}
