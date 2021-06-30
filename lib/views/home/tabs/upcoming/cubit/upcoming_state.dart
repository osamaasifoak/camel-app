part of 'upcoming_cubit.dart';

enum UpcomingStatus {
  init,
  loading,
  loadingMore,
  loaded,
  error,
}

class UpcomingState extends Equatable {
  final List<Movie> movies;
  final UpcomingStatus status;
  final int page;
  final String? errorMessage;

  const UpcomingState({
    required this.movies,   
    required this.status,
    required this.page,
    this.errorMessage
  });
  
  factory UpcomingState.init() {
    return const UpcomingState(
      movies: [],      
      status: UpcomingStatus.init,      
      page: 1,
    );
  }

  UpcomingState update({
    List<Movie>? movies,    
    UpcomingStatus? status,    
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

  @override
  List<Object> get props => [movies, status, page];
}
