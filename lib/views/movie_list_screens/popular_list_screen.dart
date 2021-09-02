import 'package:flutter/material.dart';

import '/core/constants/app_apis.dart';
import '/core/constants/app_error_messages.dart';
import '/core/constants/app_routes.dart';
import '/core/constants/singletons_names.dart';
import '/views/_screen_templates/eshow_list/full_eshow_list_screen.dart';

class PopularMoviesListScreen extends StatelessWidget {
  const PopularMoviesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FullEShowListScreen(
      title: const Text('Movies: Popular'),
      category: MovieEndpoint.popular.name,
      eShowsRepoInstanceName: SIName.repo.movies,
      eShowDetailsRouteName: AppRoutes.getMovieDetail,
      unknownErrorMessage: AppErrorMessages.popularMoviesUnknownError,
    );
  }
}
