import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/enums/state_status.dart';
import '/core/services/screen_messenger/base_screen_messenger.dart';
import '/views/_screen_templates/movie/base_movie_list_cubit/base_movie_list_cubit.dart';
import '/views/_widgets/error_screen.dart';
import '/views/_widgets/movie_list_tile/movie_list_loading_indicator.dart';
import '/views/_widgets/movie_list_tile/movie_list_tile.dart';

part 'movie_list_props.dart';
part 'movie_list_widgets.dart';

typedef BMLS = BaseMovieListState;
typedef BMLC<T extends BaseMovieListState> = BaseMovieListCubit<T>;
typedef ErrorVoidCallback = void Function(BuildContext context, String errorMessage);
typedef MovieTappedCallback = void Function(BuildContext context, int movieId);

class MovieListScreen<B extends BMLC<S>, S extends BMLS> extends StatefulWidget {
  
  const MovieListScreen({
    Key? key,
    required this.onMovieTapped,
    this.scrollController,
    this.onPopupError,
    this.onRetryError,
    this.closeCubitOnDispose = false,
  }) : super(key: key);

  final MovieTappedCallback onMovieTapped;
  final ScrollController? scrollController;
  final ErrorVoidCallback? onPopupError;
  final VoidCallback? onRetryError;
  final bool closeCubitOnDispose;

  @override
  _MovieListScreenState createState() => _MovieListScreenState<B, S>();
}

class _MovieListScreenState<B extends BMLC<S>, S extends BMLS> extends _MovieListScreenProps<B, S>
    with _MovieListScreenWidgets<B, S> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      listener: (_, state) {
        if (state.hasError && state.movies.isNotEmpty) {
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
            if (state.hasError && state.movies.isEmpty) {
              return ErrorScreen(
                errorMessage: 'Oops.. An error occurred, please try again.',
                onRetry: widget.onRetryError ?? _baseMovieListCubit.loadMovies,
              );
            }
            return movieList;
        }
      },
    );
  }
}
