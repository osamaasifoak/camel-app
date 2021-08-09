part of 'movies_sections_cubit.dart';

class MoviesSectionsState extends Equatable {
  const MoviesSectionsState({
    required this.status,
    required this.popularMovies,
    required this.nowPlayingMovies,
    required this.upcomingMovies,
    this.errorMessage,
  });

  final StateStatus status;
  final List<Movie> popularMovies;
  final List<Movie> nowPlayingMovies;
  final List<Movie> upcomingMovies;
  final String? errorMessage;

  bool get isLoading => status == StateStatus.loading;
  bool get isLoadingMore => status == StateStatus.loadingMore;
  bool get isBusy => isLoading || isLoadingMore;

  bool get hasError => status == StateStatus.error;

  factory MoviesSectionsState.init() {
    return const MoviesSectionsState(
      status: StateStatus.init,
      popularMovies: [],
      nowPlayingMovies: [],
      upcomingMovies: [],
    );
  }

  MoviesSectionsState update({
    StateStatus? status,
    List<Movie>? popularMovies,
    List<Movie>? nowPlayingMovies,
    List<Movie>? upcomingMovies,
    String? errorMessage,
  }) {
    return MoviesSectionsState(
      status: status ?? this.status,
      popularMovies: popularMovies ?? this.popularMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object> get props => [status, popularMovies, nowPlayingMovies, upcomingMovies];
}
