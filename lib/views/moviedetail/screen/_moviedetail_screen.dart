import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/services/navigation_service/base_navigation_service.dart';
import '/views/_widgets/movie_detail/movie_detail_loading_indicator.dart';
import '/views/_widgets/movie_detail/movie_tag_card.dart';
import '/views/moviedetail/cubit/moviedetail_cubit.dart';

part 'moviedetail_screen_props.dart';
part 'moviedetail_screen_widgets.dart';

class MovieDetailScreen extends StatefulWidget {
  final num? movieId;
  const MovieDetailScreen({
    required this.movieId,
  });

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends _MovieDetailScreenProps
    with _MovieDetailScreenWidgets {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieDetailCubit, MovieDetailState>(
        bloc: _movieDetailCubit,
        listener: (_, state) {
          if (state is MovieDetailError) {
            _navigationService.showSnackBar(
              message: state.errorMessage,
            );
          }
        },
        builder: (_, state) {
          switch (state.runtimeType) {
            case MovieDetailLoaded:
              return movieDetail();
            default:
              return const MovieDetailLoadingIndicator();
          }
        },
      ),
    );
  }
}
