part of 'nowplaying_cubit.dart';


class NowPlayingState extends BaseMovieListState {
  const NowPlayingState({
    required List<Movie> movies,
    required StateStatus status,
    required int page,
    String? errorMessage,
  }) : super(
        movies: movies,
        status: status,
        page: page,
        errorMessage: errorMessage,
      );

  factory NowPlayingState.init() {
    return const NowPlayingState(
      status: StateStatus.init,
      movies: [],
      page: 0,
    );
  }

  @override
  NowPlayingState update({
    List<Movie>? movies,
    StateStatus? status,
    int? page,
    String? errorMessage,
  }) {
    return NowPlayingState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      page: page ?? this.page,
      errorMessage: errorMessage,
    );
  }
}

