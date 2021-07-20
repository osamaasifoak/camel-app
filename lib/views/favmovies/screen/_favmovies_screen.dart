
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_router.dart';
import '/core/services/navigation_service/base_navigation_service.dart';
import '/views/_widgets/error_screen.dart';
import '/views/_widgets/movie_card/movie_card.dart';
import '/views/_widgets/movie_card/movies_loading_indicator.dart';
import '/views/favmovies/cubit/favmovies_cubit.dart';

part 'favmovies_screen_props.dart';
part 'favmovies_screen_widgets.dart';

class FavMoviesScreen extends StatefulWidget {
  const FavMoviesScreen({Key? key}) : super(key: key);

  @override
  _FavMoviesScreenState createState() => _FavMoviesScreenState();
}

class _FavMoviesScreenState extends _FavMoviesScreenProps
    with _FavMoviesScreenWidgets {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        elevation: 0.7,
        shadowColor: Colors.grey[100],
      ),
      body: BlocConsumer<FavMoviesCubit, FavMoviesState>(
        bloc: _favMoviesCubit,
        listener: (_, state) {
          if (state is FavMoviesError) {
            _navigationService.showSnackBar(
              message: state.errorMessage,
            );
          }
        },
        builder: (_, state) {
          switch (state.runtimeType) {
            case FavMoviesLoading:
              return loadingIndicator();
            case FavMoviesError:
              return Center(
                child: ErrorScreen(
                  errorMessage: (state as FavMoviesError).errorMessage,
                  onRetry: () => _favMoviesCubit.loadFavMovies(),
                ),
              );
            default:
              return favMovies();
          }
        },
      ),
    );
  }
}
