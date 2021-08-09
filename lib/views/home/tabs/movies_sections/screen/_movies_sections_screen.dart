import 'package:camelmovies/views/_widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_routes.dart';
import '/core/services/screen_messenger/base_screen_messenger.dart';
import '/views/_widgets/eshow_card/eshow_card.dart';
import '/views/_widgets/eshow_card/eshow_card_loading_indicator.dart';
import '/views/home/tabs/movies_sections/cubit/movies_sections_cubit.dart';

part 'movies_sections_props.dart';
part 'movies_sections_widgets.dart';

class MoviesSectionsScreen extends StatefulWidget {
  const MoviesSectionsScreen({Key? key}) : super(key: key);

  @override
  _MoviesSectionsScreenState createState() => _MoviesSectionsScreenState();
}

class _MoviesSectionsScreenState extends _MoviesSectionsProps with _MoviesSectionsWidgets {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<MoviesSectionsCubit, MoviesSectionsState>(
      bloc: _moviesSectionsCubit,
      listener: (_, state) {
        if (state.hasError) {
          GetIt.I<BaseScreenMessenger>().showSnackBar(
            context: context,
            message: state.errorMessage,
          );
        }
      },
      child: moviesSections,
    );
  }
}
