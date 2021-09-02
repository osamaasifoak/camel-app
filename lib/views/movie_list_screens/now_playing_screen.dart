import 'package:flutter/material.dart';

import '/core/constants/app_apis.dart';
import '/core/constants/app_error_messages.dart';
import '/core/constants/app_routes.dart';
import '/views/_screen_templates/eshow_list/full_eshow_list_screen.dart';

class NowPlayingMoviesListScreen extends StatelessWidget {
  const NowPlayingMoviesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FullEShowListScreen(
      title: const Text('Movies: Now Playing'),
      category: MovieEndpoint.nowPlaying.name,
      eShowsRepoInstanceName: 'movies',
      eShowDetailsRouteName: AppRoutes.getMovieDetail,
      unknownErrorMessage: AppErrorMessages.nowPlayingMoviesUnknownError,
    );
  }
}
