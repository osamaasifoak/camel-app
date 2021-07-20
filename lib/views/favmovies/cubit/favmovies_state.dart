part of 'favmovies_cubit.dart';

abstract class FavMoviesState extends Equatable {
  
  const FavMoviesState();

  @override
  List<Object?> get props => const [];

}

class FavMoviesLoading extends FavMoviesState {
  const FavMoviesLoading();
}

class FavMoviesError extends FavMoviesState {
  final String errorMessage;
  const FavMoviesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class FavMoviesLoaded extends FavMoviesState {

  final List<Movie> movies;
  // final int favCount;

  const FavMoviesLoaded({
    required this.movies, 
    // required this.favCount,
  });

  @override
  List<Object> get props => [movies, /* favCount */];

}