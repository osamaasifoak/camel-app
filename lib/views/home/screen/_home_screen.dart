
import 'package:flutter/material.dart';

import '/core/constants/app_router.dart';

import '/views/home/tabs/nowplaying/screen/_nowplaying_screen.dart';
import '/views/home/tabs/upcoming/screen/_upcoming_screen.dart';

part 'home_screen_props.dart';
part 'home_screen_widgets.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();  
}

class _HomeScreenState extends _HomeScreenProps with _HomeScreenWidgets{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movies Catalogue',
          style: TextStyle(
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.bold,
            color: Color(0xFF01579B),
          ),
        ),
        actions: [
          favIcon(),
        ],
        centerTitle: true,
        elevation: 10.0,
        shadowColor: Colors.white24,
      ),
      body: PageView(
        controller: pageController,
        children: moviePages(),
        onPageChanged: (index) => selectedIndex.value = index,
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (_, index, __) => BottomNavigationBar(
          items: bottomNavItems(),
          currentIndex: index,
          onTap: _onBottomNavTapped,
          selectedItemColor: const Color(0xFF01579B),
        ),
      ),
    );
  }

}