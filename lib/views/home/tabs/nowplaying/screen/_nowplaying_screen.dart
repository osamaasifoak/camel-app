import 'package:camelmovies/views/_widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_routes.dart';
import '/core/services/navigation_service/navigation_service.dart';
import '/views/_widgets/movie_card/movie_card.dart';
import '/views/_widgets/movie_card/movies_loading_indicator.dart';
import '/views/home/tabs/nowplaying/cubit/nowplaying_cubit.dart';

part 'nowplaying_props.dart';
part 'nowplaying_widgets.dart';

class NowPlayingScreen extends StatefulWidget {
  final ScrollController? scrollController;
  const NowPlayingScreen({this.scrollController});
  @override
  _NowPlayingScreenState createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends _NowPlayingScreenProps
    with _NowPlayingScreenWidgets {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<NowPlayingCubit, NowPlayingState>(
      listener: (_, state) {
        if (state.status == NowPlayingStatus.error) {

          navigationService.showSnackBar(
            message: state.errorMessage,
          );
          
        }
      },
      builder: (_, state) {
        switch (state.status) {
          case NowPlayingStatus.init:
          case NowPlayingStatus.loading:
            return loadingIndicator();
          case NowPlayingStatus.error:
            return ErrorScreen(
              errorMessage: 'Oops.. An error occurred, please try again.', 
              onRetry: nowPlayingCubit.loadMovies,
            );
          default:
            return nowPlayingMovies();
        }
      },
    );
  }
}
