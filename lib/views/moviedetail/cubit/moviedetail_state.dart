part of 'moviedetail_cubit.dart';

enum MovieDetailStatus {
  init,
  loading,
  loaded,
  unloaded,
  error,
}

class MovieDetailState extends Equatable {
  final MovieDetailStatus status;
  final MovieDetail movieDetail;
  final bool isFav;
  final String? errorMessage;

  const MovieDetailState({
    required this.movieDetail,
    required this.isFav,
    required this.status,
    this.errorMessage,
  });

  factory MovieDetailState.init(){
    return MovieDetailState(
      status: MovieDetailStatus.init,
      movieDetail: MovieDetail(), 
      isFav: false,
    );
  }

  MovieDetailState update({
    MovieDetail? movieDetail,
    bool? isFav,
    MovieDetailStatus? status,
    String? errorMessage,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      isFav: isFav ?? this.isFav,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object> get props => [movieDetail, isFav, status,];
}

