import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/services/screen_messenger/base_screen_messenger.dart';
import '/views/_widgets/eshow_detail/entshow_detail_loading_indicator.dart';
import '/views/_widgets/eshow_detail/entshow_tag_card.dart';
import '/views/_widgets/eshow_reviews/eshow_reviews_list.dart';
import '/views/tv_show_detail/cubit/tvshowdetail_cubit.dart';

part 'tvshowdetail_screen_props.dart';
part 'tvshowdetail_screen_widgets.dart';

class TVShowDetailScreen extends StatefulWidget {
  final int tvShowId;
  const TVShowDetailScreen({
    required this.tvShowId,
  });

  @override
  _TVShowDetailScreenState createState() => _TVShowDetailScreenState();
}

class _TVShowDetailScreenState extends _TVShowDetailScreenProps
    with _TVShowDetailScreenWidgets {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TVShowDetailCubit, TVShowDetailState>(
        bloc: _tvShowDetailCubit,
        listener: (_, state) {
          if (state is TVShowDetailError) {
            GetIt.I<BaseScreenMessenger>().showSnackBar(
              context: context,
              message: state.errorMessage,
            );
          }
        },
        builder: (_, state) {
          switch (state.runtimeType) {
            case TVShowDetailLoaded:
              return tvShowDetail;
            default:
              return const EShowDetailLoadingIndicator();
          }
        },
      ),
    );
  }
}
