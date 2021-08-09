part of 'base_tv_show_list_cubit.dart';

abstract class BaseTVShowListState extends Equatable {
  final List<TVShow> tvShows;
  final StateStatus status;
  final int page;
  final String? errorMessage;

  const BaseTVShowListState({
    required this.tvShows,   
    required this.status,
    required this.page,
    this.errorMessage,
  });

  bool get isLoading => status == StateStatus.loading;
  bool get isLoadingMore => status == StateStatus.loadingMore;
  bool get isBusy => isLoading || isLoadingMore;

  bool get hasError => status == StateStatus.error;

  BaseTVShowListState update({
    List<TVShow>? tvShows,    
    StateStatus? status,    
    int? page,
    String? errorMessage,
  });

  @override
  List<Object?> get props => [tvShows, status, page];
}

