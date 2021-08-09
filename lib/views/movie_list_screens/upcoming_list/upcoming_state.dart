part of 'upcoming_cubit.dart';


class UpcomingState extends BaseMovieListState {
  const UpcomingState({
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

  factory UpcomingState.init() {
    return const UpcomingState(
      status: StateStatus.init,
      movies: [],
      page: 0,
    );
  }

  @override
  UpcomingState update({
    List<Movie>? movies,
    StateStatus? status,
    int? page,
    String? errorMessage,
  }) {
    return UpcomingState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      page: page ?? this.page,
      errorMessage: errorMessage,
    );
  }
}
