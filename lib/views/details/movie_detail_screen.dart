import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/singletons_names.dart';
import '/core/repositories/base_eshows_repo.dart';
import '/core/repositories/base_fav_eshows_repo.dart';
import '/views/_screen_templates/eshow_detail/screen/_eshow_detail_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return EShowDetailScreen(
      id: movieId,
      eShowRepo: GetIt.I<BaseEShowsRepository>(instanceName: SIName.repo.movies),
      favEShowRepo: GetIt.I<BaseFavEShowsRepository>(instanceName: SIName.repo.favMovies),
    );
  }
}
