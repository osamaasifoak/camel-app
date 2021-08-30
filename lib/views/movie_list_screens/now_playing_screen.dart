import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_error_messages.dart';
import '/core/constants/app_routes.dart';
import '/core/repositories/movies_repo/base_movies_repo.dart';
import '/views/_screen_templates/eshow_list/cubit/eshow_list_cubit.dart';
import '/views/_screen_templates/eshow_list/screen/_eshow_list_screen.dart';

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

  void _onMovieTapped(int movieId) {
    Navigator.of(context).pushNamed(
      AppRoutes.getMovieDetail(movieId),
      arguments: context,
    );
  }

  bool _onBackPressed() {
    if(!_nowPlayingScrollController.hasClients) {
      return true;
    }
    if (_nowPlayingScrollController.offset > 100) {
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
          create: (_) => EShowListCubit(
            loadEShowCallback: GetIt.I<BaseMoviesRepository>().getNowPlaying,
            unknownErrorMessage: AppErrorMessages.nowPlayingMoviesUnknownError,
          ),
          child: EShowListScreen(
            onEShowTapped: _onMovieTapped,
            scrollController: _nowPlayingScrollController,
          ),
        ),
      ),
    );
  }
}
