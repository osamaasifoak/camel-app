part of 'tv_shows_sections_cubit.dart';

class TVShowsSectionsState extends Equatable {
  const TVShowsSectionsState({
    required this.status,
    required this.popularTVShows,
    required this.onTheAirTVShows,
    this.errorMessage,
  });

  final StateStatus status;
  final List<TVShow> popularTVShows;
  final List<TVShow> onTheAirTVShows;
  final String? errorMessage;

  bool get isLoading => status == StateStatus.loading;
  bool get isLoadingMore => status == StateStatus.loadingMore;
  bool get isBusy => isLoading || isLoadingMore;

  bool get hasError => status == StateStatus.error;

  factory TVShowsSectionsState.init() {
    return const TVShowsSectionsState(
      status: StateStatus.init,
      popularTVShows: [],
      onTheAirTVShows: [],
    );
  }

  TVShowsSectionsState update({
    StateStatus? status,
    List<TVShow>? popularTVShows,
    List<TVShow>? onTheAirTVShows,
    String? errorMessage,
  }) {
    return TVShowsSectionsState(
      status: status ?? this.status,
      popularTVShows: popularTVShows ?? this.popularTVShows,
      onTheAirTVShows: onTheAirTVShows ?? this.onTheAirTVShows,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object> get props => [status, popularTVShows, onTheAirTVShows];
}
