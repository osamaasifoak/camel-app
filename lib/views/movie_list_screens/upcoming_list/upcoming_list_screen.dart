import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constants/app_routes.dart';
import '/views/_screen_templates/movie/movie_list_screen/_movie_list_screen.dart';
import 'upcoming_cubit.dart';

class UpcomingListScreen extends StatefulWidget {
  const UpcomingListScreen({Key? key}) : super(key: key);

  @override
  _UpcomingListScreenState createState() => _UpcomingListScreenState();
}

class _UpcomingListScreenState extends State<UpcomingListScreen> {
  final _upcomingScrollController = ScrollController();

  @override
  void dispose() {
    _upcomingScrollController.dispose();
    super.dispose();
  }

  void _onMovieTapped(BuildContext context, int movieId) {
    Navigator.of(context).pushNamed(
      AppRoutes.getMovieDetail(movieId),
    );
  }

  bool _onBackPressed() {
    if (_upcomingScrollController.offset > 0.0) {
      _scrollNowPlaying();
      return false;
    }
    return true;
  }

  void _scrollNowPlaying() {
    _upcomingScrollController.animateTo(
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
          title: const Text('Upcoming'),
          elevation: 0.7,
          shadowColor: Colors.grey[100],
        ),
        body: BlocProvider(
          create: (_) => UpcomingCubit(),
          child: MovieListScreen<UpcomingCubit, UpcomingState>(
            onMovieTapped: _onMovieTapped,
            scrollController: _upcomingScrollController,
            closeCubitOnDispose: true,
          ),
        ),
      ),
    );
  }
}
