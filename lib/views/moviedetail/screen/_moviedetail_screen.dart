import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/services/navigation_service/navigation_service.dart';
import '/views/_widgets/movie_detail/movie_detail_loading_indicator.dart';
import '/views/_widgets/movie_detail/movie_tag_card.dart';
import '/views/favmovies/cubit/favmovies_cubit.dart';
import '/views/moviedetail/cubit/moviedetail_cubit.dart';

part 'moviedetail_screen_props.dart';
part 'moviedetail_screen_widgets.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen();

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends _MovieDetailScreenProps with _MovieDetailScreenWidgets {

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<MovieDetailCubit, MovieDetailState>(
        listener: (_, state) {
          if(state.status == MovieDetailStatus.error) {
            navigationService.showSnackBar(
              message: state.errorMessage,
            );
          }
        },
        builder: (_, state) {
          switch(state.status) {
            case MovieDetailStatus.loaded:
              return movieDetail();
            default:
              return MovieDetailLoadingIndicator();
            
          }
        },
      ),
    );
  }

  
}
