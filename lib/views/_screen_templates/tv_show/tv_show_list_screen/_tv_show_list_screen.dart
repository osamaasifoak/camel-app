import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/enums/state_status.dart';
import '/core/services/screen_messenger/base_screen_messenger.dart';
import '/views/_screen_templates/tv_show/base_tv_show_list_cubit/base_tv_show_list_cubit.dart';
import '/views/_widgets/error_screen.dart';
import '/views/_widgets/eshow_list_tile/eshow_list_loading_indicator.dart';
import '/views/_widgets/eshow_list_tile/eshow_list_tile.dart';

part 'tv_show_list_props.dart';
part 'tv_show_list_widgets.dart';

typedef BTVSLS = BaseTVShowListState;
typedef BTVSLC<T extends BaseTVShowListState> = BaseTVShowListCubit<T>;
typedef ErrorVoidCallback = void Function(BuildContext context, String errorMessage);
typedef TVShowTappedCallback = void Function(BuildContext context, int movieId);

class TVShowListScreen<B extends BTVSLC<S>, S extends BTVSLS> extends StatefulWidget {
  
  const TVShowListScreen({
    Key? key,
    required this.onTVShowTapped,
    this.scrollController,
    this.onPopupError,
    this.onRetryError,
    this.closeCubitOnDispose = false,
  }) : super(key: key);

  final TVShowTappedCallback onTVShowTapped;
  final ScrollController? scrollController;
  final ErrorVoidCallback? onPopupError;
  final VoidCallback? onRetryError;
  final bool closeCubitOnDispose;

  @override
  _TVShowListScreenState createState() => _TVShowListScreenState<B, S>();
}

class _TVShowListScreenState<B extends BTVSLC<S>, S extends BTVSLS> extends _TVShowListScreenProps<B, S>
    with _TVShowListScreenWidgets<B, S> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      listener: (_, state) {
        if (state.hasError && state.tvShows.isNotEmpty) {
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
      builder: (_, state) {
        switch (state.status) {
          case StateStatus.init:
          case StateStatus.loading:
            return loadingIndicator;
          default:
            if (state.hasError && state.tvShows.isEmpty) {
              return ErrorScreen(
                errorMessage: 'Oops.. An error occurred, please try again.',
                onRetry: widget.onRetryError ?? _baseTVShowListCubit.loadTVShows,
              );
            }
            return movieList;
        }
      },
    );
  }
}
