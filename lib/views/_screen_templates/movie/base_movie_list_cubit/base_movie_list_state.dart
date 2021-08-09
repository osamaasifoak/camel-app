part of 'base_movie_list_cubit.dart';

abstract class BaseMovieListState extends Equatable {
  final List<Movie> movies;
  final StateStatus status;
  final int page;
  final String? errorMessage;

  const BaseMovieListState({
    required this.movies,   
    required this.status,
    required this.page,
    this.errorMessage,
  });

  bool get isLoading => status == StateStatus.loading;
  bool get isLoadingMore => status == StateStatus.loadingMore;
  bool get isBusy => isLoading || isLoadingMore;

  bool get hasError => status == StateStatus.error;

  BaseMovieListState update({
    List<Movie>? movies,    
    StateStatus? status,    
    int? page,
    String? errorMessage,
  });

  @override
  List<Object?> get props => [movies, status, page];
}

