
import 'package:camelmovies/core/constants/app_routes.dart';
import 'package:camelmovies/views/favmovies/cubit/favmovies_cubit.dart';
import 'package:camelmovies/views/home/tabs/nowplaying/screen/_nowplaying_screen.dart';
import 'package:camelmovies/views/home/tabs/upcoming/screen/_upcoming_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: Text(
          'Movies Catalogue',
          style: TextStyle(
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue[900],
          ),
        ),
        actions: [
          favIcon(),
        ],
        centerTitle: true,
        elevation: 0.7,
      ),
      body: tabs(),
    );
  }

}