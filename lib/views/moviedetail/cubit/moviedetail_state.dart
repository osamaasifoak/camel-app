part of 'moviedetail_cubit.dart';

abstract class MovieDetailState extends Equatable {

  const MovieDetailState();

  @override
  List<Object?> get props => const [];

}

class MovieDetailLoading extends MovieDetailState{
  const MovieDetailLoading();
}

class MovieDetailError extends MovieDetailState{
  final String errorMessage;
  const MovieDetailError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  final bool isFav;

  const MovieDetailLoaded({
    required this.movieDetail,
    required this.isFav,
  });

  MovieDetailLoaded updateFav({required bool isFav}) {
    return MovieDetailLoaded(
      movieDetail: movieDetail,
      isFav: isFav,
    );
  }

  @override
  List<Object> get props => [movieDetail, isFav];
}

