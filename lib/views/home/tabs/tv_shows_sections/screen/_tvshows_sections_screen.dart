import 'package:camelmovies/views/_widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_routes.dart';
import '/core/services/screen_messenger/base_screen_messenger.dart';
import '/views/_widgets/eshow_card/eshow_card.dart';
import '/views/_widgets/eshow_card/eshow_card_loading_indicator.dart';
import '/views/home/tabs/tv_shows_sections/cubit/tv_shows_sections_cubit.dart';

part 'tvshows_sections_props.dart';
part 'tvshows_sections_widgets.dart';

class TVShowsSectionsScreen extends StatefulWidget {
  const TVShowsSectionsScreen({Key? key}) : super(key: key);

  @override
  _TVShowsSectionsScreenState createState() => _TVShowsSectionsScreenState();
}

class _TVShowsSectionsScreenState extends _TVShowsSectionsProps with _TVShowsSectionsWidgets {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<TVShowsSectionsCubit, TVShowsSectionsState>(
      bloc: _tvShowsSectionsCubit,
      listener: (_, state) {
        if (state.hasError) {
          GetIt.I<BaseScreenMessenger>().showSnackBar(
            context: context,
            message: state.errorMessage,
          );
        }
      },
      child: tvShowsSections,
    );
  }
}
