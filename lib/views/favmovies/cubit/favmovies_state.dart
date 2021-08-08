part of 'favmovies_cubit.dart';

enum FavMoviesStatus {
  init,
  loading,
  loaded,
  loadingMore,
  error,
}

class FavMoviesState extends Equatable {
  const FavMoviesState({
    required this.status,
    required this.currentPage,
    required this.movies,
    this.isAtEndOfPage = false,
    this.errorMessage,
  });

  final FavMoviesStatus status;
  final int currentPage;
  final List<Movie> movies;
  final bool isAtEndOfPage;
  final String? errorMessage;

  bool get isLoading => status == FavMoviesStatus.loading;
  bool get isLoadingMore => status == FavMoviesStatus.loadingMore;
  bool get isBusy => isLoading || isLoadingMore;

  bool get hasError => status == FavMoviesStatus.error;

  factory FavMoviesState.init() {
    return const FavMoviesState(
      status: FavMoviesStatus.init,
      currentPage: 0,
      movies: [],
    );
  }

  FavMoviesState loading() {
    return const FavMoviesState(
      status: FavMoviesStatus.loading,
      currentPage: 0,
      movies: [],
    );
  }

  FavMoviesState loadingMore({
    List<Movie>? movies,
  }) {
    return FavMoviesState(
      status: FavMoviesStatus.loadingMore,
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
      status: FavMoviesStatus.loaded,
      isAtEndOfPage: isAtEndOfPage ?? this.isAtEndOfPage,
      currentPage: newPage ?? currentPage,
      movies: movies,
    );
  }

  FavMoviesState error({
    required String errorMessage,
  }) {
    return FavMoviesState(
      status: FavMoviesStatus.error,
      isAtEndOfPage: isAtEndOfPage,
      currentPage: currentPage,
      movies: movies,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, currentPage, movies, isAtEndOfPage];
}
