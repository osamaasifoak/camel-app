import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/singletons_names.dart';
import '/core/repositories/base_eshows_repo.dart';
import '/core/repositories/base_fav_eshows_repo.dart';
import '/views/_screen_templates/eshow_detail/screen/_eshow_detail_screen.dart';

class TVShowDetailScreen extends StatelessWidget {
  const TVShowDetailScreen({
    Key? key,
    required this.tvShowId,
  }) : super(key: key);

  final int tvShowId;

  @override
  Widget build(BuildContext context) {
    return EShowDetailScreen(
      id: tvShowId,
      eShowRepo: GetIt.I<BaseEShowsRepository>(instanceName: SIName.repo.tvShows),
      favEShowRepo: GetIt.I<BaseFavEShowsRepository>(instanceName: SIName.repo.favTVShows),
    );
  }
}
