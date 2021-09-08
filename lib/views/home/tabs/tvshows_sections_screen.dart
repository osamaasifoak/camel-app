import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_apis.dart';
import '/core/constants/app_routes.dart';
import '/core/constants/singletons_names.dart';
import '/core/models/entertainment_show/entertainment_show.dart';
import '/core/models/eshow_section/eshow_section_list_provider.dart';
import '/core/repositories/base_eshows_repo.dart';
import '/views/_screen_templates/eshow_sections/screen/eshow_sections_screen.dart';

class TVShowsSectionsScreen extends StatelessWidget {
  const TVShowsSectionsScreen({Key? key}) : super(key: key);

  void _goToPopularTVShowList(BuildContext context) {
  Navigator.of(context).pushNamed(
    AppRoutes.popularTVShowList,
  );
}

  void _goToOnTheAirTVShowList(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.onTheAirTVShowList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return EShowSectionsScreen(
      eShowRepo: GetIt.I<BaseEShowsRepository>(
        instanceName: SIName.repo.tvShows,
      ),
      providers: <EShowSectionListProvider>[
        EShowSectionListProvider(
          title: 'Popular',
          category: TVEndpoint.popular.name,
          onSectionTapped: _goToPopularTVShowList,
        ),
        EShowSectionListProvider(
          title: 'On The Air',
          category: TVEndpoint.onTheAir.name,
          onSectionTapped: _goToOnTheAirTVShowList,
        ),
      ],
      onEShowTapped: (BuildContext context, EShow eShow) {
        Navigator.of(context).pushNamed(
          AppRoutes.getTVShowDetail(eShow.id),
          arguments: context,
        );
      },
      unknownErrorMessage: 'Failed to fetch tv shows sections :( Please try again.',
    );
  }
}
