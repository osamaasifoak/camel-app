import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../tabs/movies_sections_screen.dart';
import '../tabs/profile_screen.dart';
import '../tabs/tvshows_sections_screen.dart';
import '/core/constants/app_routes.dart';
import '/core/constants/singletons_names.dart';
import '/core/repositories/base_fav_eshows_repo.dart';
import '/views/_widgets/fav_count_icon.dart';

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
          onSearchTapped: _goToSearchScreen,
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
