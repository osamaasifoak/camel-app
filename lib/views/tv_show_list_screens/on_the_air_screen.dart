import 'package:flutter/material.dart';

import '/core/constants/app_apis.dart';
import '/core/constants/app_error_messages.dart';
import '/core/constants/app_routes.dart';
import '/core/constants/singletons_names.dart';
import '/views/_screen_templates/eshow_list/full_eshow_list_screen.dart';

class OnTheAirTVShowsListScreen extends StatelessWidget {
  const OnTheAirTVShowsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FullEShowListScreen(
      title: const Text('TV Shows: On The Air'),
      category: TVEndpoint.onTheAir.name,
      eShowsRepoInstanceName: SIName.repo.tvShows,
      eShowDetailsRouteName: AppRoutes.getTVShowDetail,
      unknownErrorMessage: AppErrorMessages.onTheAirTVShowsUnknownError,
    );
  }
}