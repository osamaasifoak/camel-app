part of 'popular_cubit.dart';

class PopularState extends BaseMovieListState {
  const PopularState({
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

  factory PopularState.init() {
    return const PopularState(
      status: StateStatus.init,
      movies: [],
      page: 0,
    );
  }

  @override
  PopularState update({
    List<Movie>? movies,
    StateStatus? status,
    int? page,
    String? errorMessage,
  }) {
    return PopularState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      page: page ?? this.page,
      errorMessage: errorMessage,
    );
  }
}
