import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constants/app_routes.dart';
import '/views/_screen_templates/tv_show/tv_show_list_screen/_tv_show_list_screen.dart';
import 'ontheair_cubit.dart';

class OnTheAirTVShowListScreen extends StatefulWidget {
  const OnTheAirTVShowListScreen({Key? key}) : super(key: key);

  @override
  _OnTheAirTVShowListScreenState createState() => _OnTheAirTVShowListScreenState();
}

class _OnTheAirTVShowListScreenState extends State<OnTheAirTVShowListScreen> {
  final _onTheAirTVShowScrollController = ScrollController();

  @override
  void dispose() {
    _onTheAirTVShowScrollController.dispose();
    super.dispose();
  }

  void _onTVShowTapped(BuildContext context, int tvShowId) {
    Navigator.of(context).pushNamed(AppRoutes.getTVShowDetail(tvShowId));
  }

  bool _onBackPressed() {
    if (_onTheAirTVShowScrollController.offset > 0.0) {
      _scrollOnTheAirTVShow();
      return false;
    }
    return true;
  }

  void _scrollOnTheAirTVShow() {
    _onTheAirTVShowScrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _onBackPressed(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TV Shows: On The Air'),
          elevation: 0.7,
          shadowColor: Colors.grey[100],
        ),
        body: BlocProvider(
          create: (_) => OnTheAirTVShowCubit(),
          child: TVShowListScreen<OnTheAirTVShowCubit, OnTheAirTVShowState>(
            onTVShowTapped: _onTVShowTapped,
            scrollController: _onTheAirTVShowScrollController,
            closeCubitOnDispose: true,
          ),
        ),
      ),
    );
  }
}
