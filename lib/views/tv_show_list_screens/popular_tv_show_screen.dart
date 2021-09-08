import 'package:flutter/material.dart';

import '/core/constants/app_apis.dart';
import '/core/constants/app_error_messages.dart';
import '/core/constants/app_routes.dart';
import '/core/constants/singletons_names.dart';
import '/views/_screen_templates/eshow_list/full_eshow_list_screen.dart';

class PopularTVShowsListScreen extends StatelessWidget {
  const PopularTVShowsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FullEShowListScreen(
      title: const Text('TV Shows: Popular'),
      category: TVEndpoint.popular.name,
      eShowsRepoInstanceName: SIName.repo.tvShows,
      eShowDetailsRouteName: AppRoutes.getTVShowDetail,
      unknownErrorMessage: AppErrorMessages.popularTVShowsUnknownError,
    );
  }
}
