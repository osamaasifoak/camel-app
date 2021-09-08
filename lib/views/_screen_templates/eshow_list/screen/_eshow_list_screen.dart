import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/services/screen_messenger/base_screen_messenger.dart';
import '/views/_screen_templates/eshow_list/cubit/eshow_list_cubit.dart';
import '/views/_widgets/error_screen.dart';
import '/views/_widgets/eshow_list_tile/eshow_list_loading_indicator.dart';
import '/views/_widgets/eshow_list_view/eshow_list_view.dart';

part 'eshow_list_props.dart';

typedef ErrorVoidCallback = void Function(BuildContext context, String errorMessage);
typedef EShowTappedCallback = void Function(int id);

class EShowListScreen extends StatefulWidget {
  const EShowListScreen({
    Key? key,
    required this.onEShowTapped,
    this.scrollController,
    this.onPopupError,
    this.onRetryError,
  }) : super(key: key);

  final EShowTappedCallback onEShowTapped;
  final ScrollController? scrollController;
  final ErrorVoidCallback? onPopupError;
  final VoidCallback? onRetryError;

  @override
  _EShowListScreenState createState() => _EShowListScreenState();
}

class _EShowListScreenState extends _EShowListScreenProps {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EShowListCubit, EShowListState>(
      listener: (_, EShowListState state) {
        if (state.hasError && state.eShows.isNotEmpty) {
          if (widget.onPopupError != null) {
            widget.onPopupError!(context, state.errorMessage!);
          } else {
            GetIt.I<BaseScreenMessenger>().showSnackBar(
              context: context,
              message: state.errorMessage,
            );
          }
        }
      },
      builder: (_, EShowListState state) {
        if (state.isInit || state.isLoading && state.eShows.isEmpty) {
          return const EShowListLoadingIndicator(
            withCustomScrollView: true,
            itemCount: 10,
          );
        }
        
        if (state.hasError && state.eShows.isEmpty) {
          return Center(
            child: ErrorScreen(
              errorMessage: state.errorMessage!,
              onRetry: widget.onRetryError ?? _currentEShowListCubit.loadEShows,
            ),
          );
        }
        return EShowListView(
          eShows: state.eShows,
          onRefresh: _currentEShowListCubit.loadEShows,
          onEShowTapped: widget.onEShowTapped,
          isLoadingMore: state.isLoadingMore,
          listScrollController: _eShowListController,
        );
      },
    );
  }
}
