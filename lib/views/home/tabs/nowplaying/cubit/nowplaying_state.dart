part of 'nowplaying_cubit.dart';

enum NowPlayingStatus {
  init,
  loading,
  loadingMore,
  loaded,
  error,
}

class NowPlayingState extends Equatable {
  final List<Movie> movies;
  final NowPlayingStatus status;
  final int page;
  final String? errorMessage;

  const NowPlayingState({
    required this.movies,   
    required this.status,
    required this.page,
    this.errorMessage,
  });

  bool get isLoading => status == NowPlayingStatus.loading;
  bool get isLoadingMore => status == NowPlayingStatus.loadingMore;
  bool get isBusy => isLoading || isLoadingMore;

  bool get hasError => status == NowPlayingStatus.error;

  factory NowPlayingState.init() {
    return const NowPlayingState(
      movies: [],      
      status: NowPlayingStatus.init,      
      page: 1,
    );
  }

  NowPlayingState update({
    List<Movie>? movies,    
    NowPlayingStatus? status,    
    int? page,
    String? errorMessage,
  }) {
    return NowPlayingState(
      movies: movies ?? this.movies,     
      status: status ?? this.status,  
      page: page ?? this.page,
      errorMessage: errorMessage,
    );
  } 

  @override
  List<Object> get props => [movies, status, page];
}

