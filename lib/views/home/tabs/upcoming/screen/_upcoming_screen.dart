import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_routes.dart';
import '/core/services/navigation_service/navigation_service.dart';
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
          navigationService.showSnackBar(
            message: state.errorMessage,
          );
        }
        // if(state.scrollToTopRequested && _scrollController!.offset > 0)
        //   _scrollController!.animateTo(
        //     0, 
        //     duration: Duration(milliseconds: 500), 
        //     curve: Curves.ease);  
      },
      builder: (_, state){
        switch(state.status) {
          case UpcomingStatus.init:
          case UpcomingStatus.loading:
            return loadingIndicator();
          default:
            return upcomingMovies();
        }
      },
    );
  }
  
}