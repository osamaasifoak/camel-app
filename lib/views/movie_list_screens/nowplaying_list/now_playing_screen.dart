import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constants/app_routes.dart';
import '/views/_screen_templates/movie/movie_list_screen/_movie_list_screen.dart';

import 'nowplaying_cubit.dart';

class NowPlayingListScreen extends StatefulWidget {
  const NowPlayingListScreen({Key? key}) : super(key: key);

  @override
  _NowPlayingListScreenState createState() => _NowPlayingListScreenState();
}

class _NowPlayingListScreenState extends State<NowPlayingListScreen> {
  final _nowPlayingScrollController = ScrollController();

  @override
  void dispose() {
    _nowPlayingScrollController.dispose();
    super.dispose();
  }

  void _onMovieTapped(BuildContext context, int movieId) {
    Navigator.of(context).pushNamed(
      AppRoutes.getMovieDetail(movieId)
    );
  }

  bool _onBackPressed() {
    if (_nowPlayingScrollController.offset > 0.0) {
      _scrollNowPlaying();
      return false;
    }
    return true;
  }

  void _scrollNowPlaying() {
    _nowPlayingScrollController.animateTo(
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
          title: const Text('Now Playing'),
          elevation: 0.7,
          shadowColor: Colors.grey[100],
        ),
        body: BlocProvider(
          create: (_) => NowPlayingCubit(),
          child: MovieListScreen<NowPlayingCubit, NowPlayingState>(
            onMovieTapped: _onMovieTapped,
            scrollController: _nowPlayingScrollController,
            closeCubitOnDispose: true,
          ),
        ),
      ),
    );
  }
}
