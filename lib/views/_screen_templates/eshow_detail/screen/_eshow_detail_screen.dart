import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '/core/helpers/app_cache_manager.dart';
import '/core/helpers/screen_sizer.dart';
import '/core/repositories/base_eshows_repo.dart';
import '/core/repositories/base_fav_eshows_repo.dart';
import '/core/services/screen_messenger/base_screen_messenger.dart';
import '/views/_screen_templates/eshow_detail/cubit/eshow_detail_cubit.dart';
import '/views/_widgets/eshow_detail/entshow_detail_loading_indicator.dart';
import '/views/_widgets/eshow_detail/entshow_tag_card.dart';
import '/views/_widgets/eshow_reviews/eshow_reviews_list.dart';

part 'eshow_detail_screen_props.dart';
part 'eshow_detail_screen_widgets.dart';

final _dateFormatter = DateFormat('MMMM dd, yyyy');

class EShowDetailScreen extends StatefulWidget {
  const EShowDetailScreen({
    required this.id,
    required this.eShowRepo,
    required this.favEShowRepo,
  });

  final int id;
  final BaseEShowsRepository eShowRepo;
  final BaseFavEShowsRepository favEShowRepo;

  @override
  _EShowDetailScreenState createState() => _EShowDetailScreenState();
}

class _EShowDetailScreenState extends _EShowDetailScreenProps with _EShowDetailScreenWidgets {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EShowDetailCubit, EShowDetailState>(
        bloc: _eShowDetailCubit,
        listener: (_, state) {
          if (state.hasError) {
            GetIt.I<BaseScreenMessenger>().showSnackBar(
              context: context,
              message: state.errorMessage,
            );
          }
        },
        builder: (_, state) {
          if (state.isLoaded) {
            return eShowDetails;
          }

          return const EShowDetailLoadingIndicator();
        },
      ),
    );
  }
}
