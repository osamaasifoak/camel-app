
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_routes.dart';
import '/core/enums/state_status.dart';
import '/core/services/screen_messenger/base_screen_messenger.dart';
import '/views/_widgets/error_screen.dart';
import '/views/_widgets/movie_list_tile/movie_list_loading_indicator.dart';
import '/views/_widgets/tv_show_list_tile/tvshow_list_tile.dart';
import '/views/fav_tv_shows/cubit/favtvshows_cubit.dart';

part 'favtvshows_screen_props.dart';
part 'favtvshows_screen_widgets.dart';

class FavTVShowsScreen extends StatefulWidget {
  const FavTVShowsScreen({Key? key}) : super(key: key);

  @override
  _FavTVShowsScreenState createState() => _FavTVShowsScreenState();
}

class _FavTVShowsScreenState extends _FavTVShowsScreenProps
    with _FavTVShowsScreenWidgets {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your favorite TV shows'),
        elevation: 0.7,
        shadowColor: Colors.grey[100],
      ),
      body: BlocConsumer<FavTVShowsCubit, FavTVShowsState>(
        bloc: _favTVShowsCubit,
        listener: (_, state) {
          if (state.hasError) {
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
              if(state.hasError && state.tvShows.isEmpty) {
                return Center(
                  child: ErrorScreen(
                    errorMessage: state.errorMessage!,
                    onRetry: _favTVShowsCubit.loadFavTVShows,
                  ),
                );
              }
              return favTVShowsList;
          }
        },
      ),
    );
  }
}
