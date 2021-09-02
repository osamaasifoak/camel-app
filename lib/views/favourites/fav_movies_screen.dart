import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_error_messages.dart';
import '/core/constants/app_routes.dart';
import '/core/constants/singletons_names.dart';
import '/core/repositories/base_eshows_repo.dart';
import '/core/repositories/base_fav_eshows_repo.dart';
import '/views/_screen_templates/fav_eshow_list/cubit/fav_eshow_list_cubit.dart';
import '/views/_screen_templates/fav_eshow_list/screen/_fav_eshow_list_screen.dart';

class FavMoviesScreen extends StatelessWidget {
  const FavMoviesScreen({Key? key}) : super(key: key);

  Future<void> _onFavMovieTapped(BuildContext context, int movieId) async {
    await Navigator.of(context).pushNamed(
      AppRoutes.getMovieDetail(movieId),
      arguments: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavEShowListCubit(
        eShowsRepo: GetIt.I<BaseEShowsRepository>(instanceName: SIName.repo.movies),
        favEShowRepo: GetIt.I<BaseFavEShowsRepository>(instanceName: SIName.repo.favMovies),
        unknownErrorMessage: AppErrorMessages.favMoviesUnknownError,
      ),
      child: FavEShowListScreen(
        appBarTitle: const Text('Your favorite movies'),
        onEShowTapped: _onFavMovieTapped,
      ),
    );
  }
}