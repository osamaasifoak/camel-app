part of 'favtvshows_cubit.dart';

class FavTVShowsState extends Equatable {
  const FavTVShowsState({
    required this.status,
    required this.currentPage,
    required this.tvShows,
    this.isAtEndOfPage = false,
    this.errorMessage,
  });

  final StateStatus status;
  final int currentPage;
  final List<TVShow> tvShows;
  final bool isAtEndOfPage;
  final String? errorMessage;

  bool get isLoading => status == StateStatus.loading;
  bool get isLoadingMore => status == StateStatus.loadingMore;
  bool get isBusy => isLoading || isLoadingMore;

  bool get hasError => status == StateStatus.error;

  factory FavTVShowsState.init() {
    return const FavTVShowsState(
      status: StateStatus.init,
      currentPage: 0,
      tvShows: [],
    );
  }

  FavTVShowsState loading() {
    return const FavTVShowsState(
      status: StateStatus.loading,
      currentPage: 0,
      tvShows: [],
    );
  }

  FavTVShowsState loadingMore({
    List<TVShow>? tvShows,
  }) {
    return FavTVShowsState(
      status: StateStatus.loadingMore,
      currentPage: currentPage,
      tvShows: tvShows ?? this.tvShows,
    );
  }

  FavTVShowsState loaded({
    required List<TVShow> tvShows,
    bool? isAtEndOfPage,
    int? newPage,
  }) {
    return FavTVShowsState(
      status: StateStatus.loaded,
      isAtEndOfPage: isAtEndOfPage ?? this.isAtEndOfPage,
      currentPage: newPage ?? currentPage,
      tvShows: tvShows,
    );
  }

  FavTVShowsState error({
    required String errorMessage,
  }) {
    return FavTVShowsState(
      status: StateStatus.error,
      isAtEndOfPage: isAtEndOfPage,
      currentPage: currentPage,
      tvShows: tvShows,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, currentPage, tvShows, isAtEndOfPage];
}
