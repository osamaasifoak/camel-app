import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_apis.dart';
import '/core/constants/app_routes.dart';
import '/core/constants/singletons_names.dart';
import '/core/models/eshow_section/eshow_section_list_provider.dart';
import '/core/repositories/base_eshows_repo.dart';
import '/views/_screen_templates/eshow_sections/screen/eshow_sections_screen.dart';

class MoviesSectionsScreen extends StatelessWidget {
  const MoviesSectionsScreen({Key? key}) : super(key: key);

  void _goToPopularMovieList(BuildContext context) {
  Navigator.of(context).pushNamed(
    AppRoutes.popularMovieList,
  );
}

  void _goToNowPlayingMovieList(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.nowPlayingMovieList,
    );
  }

  void _goToUpcomingMovieList(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.upcomingMovieList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return EShowSectionsScreen(
      eShowRepo: GetIt.I<BaseEShowsRepository>(
        instanceName: SIName.repo.movies,
      ),
      providers: [
        EShowSectionListProvider(
          title: 'Popular',
          category: MovieEndpoint.popular.name,
          onSectionTapped: _goToPopularMovieList,
        ),
        EShowSectionListProvider(
          title: 'Now Playing',
          category: MovieEndpoint.nowPlaying.name,
          onSectionTapped: _goToNowPlayingMovieList,
        ),
        EShowSectionListProvider(
          title: 'Upcoming',
          category: MovieEndpoint.upcoming.name,
          onSectionTapped: _goToUpcomingMovieList,
        ),
      ],
      onEShowTapped: (context, eShow) {
        Navigator.of(context).pushNamed(
          AppRoutes.getMovieDetail(eShow.id),
          arguments: context,
        );
      },
      unknownErrorMessage: 'Failed to fetch movies sections :( Please try again.',
    );
  }
}
