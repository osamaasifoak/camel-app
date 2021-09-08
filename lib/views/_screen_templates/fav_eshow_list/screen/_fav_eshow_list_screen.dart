import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/services/screen_messenger/base_screen_messenger.dart';
import '/views/_screen_templates/fav_eshow_list/cubit/fav_eshow_list_cubit.dart';
import '/views/_widgets/error_screen.dart';
import '/views/_widgets/eshow_list_tile/eshow_list_loading_indicator.dart';
import '/views/_widgets/eshow_list_view/eshow_list_view.dart';

part 'fav_eshow_list_props.dart';

class FavEShowListScreen extends StatefulWidget {
  const FavEShowListScreen({
    Key? key,
    required this.appBarTitle,
    required this.onEShowTapped,
  }) : super(key: key);

  final Future<void> Function(BuildContext context, int eShowId) onEShowTapped;
  final Widget appBarTitle;

  @override
  _FavEShowListScreenState createState() => _FavEShowListScreenState();
}

class _FavEShowListScreenState extends _FavEShowListProps {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.appBarTitle,
        elevation: 0.7,
        shadowColor: Colors.grey[100],
      ),
      body: BlocConsumer<FavEShowListCubit, FavEShowListState>(
        listener: (_, FavEShowListState state) {
          if (state.hasError && state.favEShows.isNotEmpty) {
            GetIt.I<BaseScreenMessenger>().showSnackBar(
              context: context,
              message: state.errorMessage,
            );
          }
        },
        builder: (_, FavEShowListState state) {
          if(state.isInit || state.isLoading && state.favEShows.isEmpty) {
            return const EShowListLoadingIndicator(
            withCustomScrollView: true,
            itemCount: 10,
          );
          }
          if (state.hasError && state.favEShows.isEmpty) {
            return Center(
              child: ErrorScreen(
                errorMessage: state.errorMessage!,
                onRetry: _currentFavEShowListCubit.loadFavEShows,
              ),
            );
          }
          return EShowListView(
            eShows: state.favEShows,
            onRefresh: _currentFavEShowListCubit.loadFavEShows,
            onEShowTapped: _onFavEShowTapped,
            isLoadingMore: state.isLoadingMore,
            listScrollController: _favEShowListController,
          );
        },
      ),
    );
  }
}
