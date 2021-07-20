import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_router.dart';
import '/core/services/navigation_service/base_navigation_service.dart';
import '/views/_widgets/error_screen.dart';
import '/views/_widgets/movie_card/movie_card.dart';
import '/views/_widgets/movie_card/movies_loading_indicator.dart';
import '/views/home/tabs/upcoming/cubit/upcoming_cubit.dart';

part 'upcoming_props.dart';
part 'upcoming_widgets.dart';

class UpcomingScreen extends StatefulWidget{
  final ScrollController? scrollController;
  const UpcomingScreen({this.scrollController});
  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();  
}

class _UpcomingScreenState extends _UpcomingScreenProps with _UpcomingScreenWidgets{
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<UpcomingCubit, UpcomingState>(
      listener: (_, state){
        if (state.status == UpcomingStatus.error) {

          _navigationService.showSnackBar(

            message: state.errorMessage,

          );

        }  
      },
      builder: (_, state){
        switch(state.status) {
          case UpcomingStatus.init:
          case UpcomingStatus.loading:
            return loadingIndicator();
          case UpcomingStatus.error:
            return ErrorScreen(
              errorMessage: 'Oops.. An error occurred, please try again.',
              onRetry: _upcomingCubit.loadMovies,
            );
          default:
            return upcomingMovies();
        }
      },
    );
  }
  
}