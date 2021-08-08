
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_routes.dart';
import '/core/repositories/favmovies_repo/base_favmovies_repo.dart';
import '/core/services/localdb_service/base_localdb_service.dart';
import '/core/services/network_service/base_network_service.dart';
import '/views/home/tabs/nowplaying/cubit/nowplaying_cubit.dart';
import '/views/home/tabs/nowplaying/screen/_nowplaying_screen.dart';
import '/views/home/tabs/upcoming/cubit/upcoming_cubit.dart';
import '/views/home/tabs/upcoming/screen/_upcoming_screen.dart';

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
        title: const Text(
          'caMel',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF01579B),
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
        onPageChanged: (index) => _selectedIndex.value = index,
        children: moviePages,
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (_, index, __) => BottomNavigationBar(
          items: bottomNavItems,
          currentIndex: index,
          onTap: _onBottomNavTapped,
          selectedItemColor: const Color(0xFF01579B),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
