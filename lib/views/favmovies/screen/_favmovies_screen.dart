
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_routes.dart';
import '/core/enums/state_status.dart';
import '/core/services/screen_messenger/base_screen_messenger.dart';
import '/views/_widgets/error_screen.dart';
import '/views/_widgets/eshow_list_tile/eshow_list_loading_indicator.dart';
import '/views/_widgets/eshow_list_tile/eshow_list_tile.dart';
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
        title: const Text('Your favorite movies'),
        elevation: 0.7,
        shadowColor: Colors.grey[100],
      ),
      body: BlocConsumer<FavMoviesCubit, FavMoviesState>(
        bloc: _favMoviesCubit,
        listener: (_, state) {
          if (state.hasError && state.movies.isNotEmpty) {
            GetIt.I<BaseScreenMessenger>().showSnackBar(
              context: context,
              message: state.errorMessage,
            );
          }
        },
        builder: (_, state) {
          switch (state.status) {
            case StateStatus.loading:
              return loadingIndicator;
            default:
              if(state.hasError && state.movies.isEmpty) {
                return Center(
                  child: ErrorScreen(
                    errorMessage: state.errorMessage!,
                    onRetry: _favMoviesCubit.loadFavMovies,
                  ),
                );
              }
              return favMoviesList;
          }
        },
      ),
    );
  }
}
