import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:postor/postor.dart';

import '/core/constants/app_routes.dart';
import '/core/repositories/fav_tv_shows_repo/base_fav_tv_shows_repo.dart';
import '/core/repositories/favmovies_repo/base_favmovies_repo.dart';
import '/core/services/localdb_service/base_localdb_service.dart';
import '/views/_widgets/fav_count_icon.dart';
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
        title: _AnimatedHomeScreenTitle(
          bottomNavSelectedIndex: _bottomNavSelectedIndex,
        ),
        actions: [favIcon],
        centerTitle: true,
        elevation: 10.0,
        shadowColor: Colors.white24,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
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
