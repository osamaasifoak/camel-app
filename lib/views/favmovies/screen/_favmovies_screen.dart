
import 'package:camelmovies/core/constants/app_routes.dart';
import 'package:camelmovies/core/services/navigation_service/navigation_service.dart';
import 'package:camelmovies/views/_widgets/movie_card/movie_card.dart';
import 'package:camelmovies/views/_widgets/movie_card/movies_loading_indicator.dart';
import 'package:camelmovies/views/favmovies/cubit/favmovies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'favmovies_screen_props.dart';
part 'favmovies_screen_widgets.dart';

class FavMoviesScreen extends StatefulWidget{
  const FavMoviesScreen();

  @override
  _FavMoviesScreenState createState() => _FavMoviesScreenState();
}

class _FavMoviesScreenState extends _FavMoviesScreenProps with _FavMoviesScreenWidgets{

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Favorites'),
        elevation: 0.7,
        shadowColor: Colors.grey[100],
      ),

      body: BlocConsumer<FavMoviesCubit, FavMoviesState>(
        listener: (_, state) {
          if (state.status == FavMoviesStatus.error) {
            navigationService.showSnackBar(
              message: state.errorMessage,
            );
          }
        },
        builder: (_, state) {
          switch(state.status) {
            case FavMoviesStatus.loading:
              return loadingIndicator();
            default:
              return favMovies();
          }
        },
      ),
    );
    
  }

}