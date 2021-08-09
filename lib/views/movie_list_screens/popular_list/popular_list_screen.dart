import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constants/app_routes.dart';
import '/views/_screen_templates/movie/movie_list_screen/_movie_list_screen.dart';
import 'popular_cubit.dart';

class PopularListScreen extends StatefulWidget {
  const PopularListScreen({Key? key}) : super(key: key);

  @override
  _PopularListScreenState createState() => _PopularListScreenState();
}

class _PopularListScreenState extends State<PopularListScreen> {
  final _popularScrollController = ScrollController();

  @override
  void dispose() {
    _popularScrollController.dispose();
    super.dispose();
  }

  void _onMovieTapped(BuildContext context, int movieId) {
    Navigator.of(context).pushNamed(
      AppRoutes.getMovieDetail(movieId)
    );
  }

  bool _onBackPressed() {
    if (_popularScrollController.offset > 0.0) {
      _scrollNowPlaying();
      return false;
    }
    return true;
  }

  void _scrollNowPlaying() {
    _popularScrollController.animateTo(
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
          title: const Text('Popular'),
          elevation: 0.7,
          shadowColor: Colors.grey[100],
        ),
        body: BlocProvider(
          create: (_) => PopularCubit(),
          child: MovieListScreen<PopularCubit, PopularState>(
            onMovieTapped: _onMovieTapped,
            scrollController: _popularScrollController,
            closeCubitOnDispose: true,
          ),
        ),
      ),
    );
  }
}
