
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constants/app_routes.dart';
import '/views/favmovies/cubit/favmovies_cubit.dart';
import '/views/home/tabs/nowplaying/screen/_nowplaying_screen.dart';
import '/views/home/tabs/upcoming/screen/_upcoming_screen.dart';

part 'home_screen_props.dart';
part 'home_screen_widgets.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen();

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
            color: Color(0xFF01579B) // Colors.blue[900],
          ),
        ),
        actions: [
          favIcon(),
        ],
        centerTitle: true,
        elevation: 0.7,
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
          onTap: onBottomNavTapped,
        ),
      ),
    );
  }

}