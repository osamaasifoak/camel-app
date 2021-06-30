part of 'favmovies_cubit.dart';

enum FavMoviesStatus{
  init,
  loading,
  loaded,
  error,
}

class FavMoviesState extends Equatable {
  final List<Movie> movies;
  final FavMoviesStatus status;
  final int favCount;
  final String? errorMessage;

  const FavMoviesState({
    required this.movies, 
    required this.status,
    required this.favCount,
    this.errorMessage,
  });

  factory FavMoviesState.init(){
    return FavMoviesState(
      movies: [], 
      status: FavMoviesStatus.init,
      favCount: 0,
    );
  }
  
  FavMoviesState update({
    List<Movie>? movies,
    FavMoviesStatus? status,
    int? favCount,
    String? errorMessage,
  }) {
    return FavMoviesState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      favCount: favCount ?? this.favCount,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object> get props => [movies, status];

}

