part of 'favmovies_cubit.dart';

class FavMoviesState extends Equatable {
  const FavMoviesState({
    required this.status,
    required this.currentPage,
    required this.movies,
    this.isAtEndOfPage = false,
    this.errorMessage,
  });

  final StateStatus status;
  final int currentPage;
  final List<Movie> movies;
  final bool isAtEndOfPage;
  final String? errorMessage;

  bool get isLoading => status == StateStatus.loading;
  bool get isLoadingMore => status == StateStatus.loadingMore;
  bool get isBusy => isLoading || isLoadingMore;

  bool get hasError => status == StateStatus.error;

  factory FavMoviesState.init() {
    return const FavMoviesState(
      status: StateStatus.init,
      currentPage: 0,
      movies: [],
    );
  }

  FavMoviesState loading() {
    return const FavMoviesState(
      status: StateStatus.loading,
      currentPage: 0,
      movies: [],
    );
  }

  FavMoviesState loadingMore({
    List<Movie>? movies,
  }) {
    return FavMoviesState(
      status: StateStatus.loadingMore,
      currentPage: currentPage,
      movies: movies ?? this.movies,
    );
  }

  FavMoviesState loaded({
    required List<Movie> movies,
    bool? isAtEndOfPage,
    int? newPage,
  }) {
    return FavMoviesState(
      status: StateStatus.loaded,
      isAtEndOfPage: isAtEndOfPage ?? this.isAtEndOfPage,
      currentPage: newPage ?? currentPage,
      movies: movies,
    );
  }

  FavMoviesState error({
    required String errorMessage,
  }) {
    return FavMoviesState(
      status: StateStatus.error,
      isAtEndOfPage: isAtEndOfPage,
      currentPage: currentPage,
      movies: movies,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, currentPage, movies, isAtEndOfPage];
}
