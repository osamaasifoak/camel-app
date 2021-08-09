part of 'ontheair_cubit.dart';

class OnTheAirTVShowState extends BaseTVShowListState {
  const OnTheAirTVShowState({
    required List<TVShow> tvShows,
    required StateStatus status,
    required int page,
    String? errorMessage,
  }) : super(
          tvShows: tvShows,
          status: status,
          page: page,
          errorMessage: errorMessage,
        );

  factory OnTheAirTVShowState.init() {
    return const OnTheAirTVShowState(
      status: StateStatus.init,
      tvShows: [],
      page: 0,
    );
  }

  @override
  OnTheAirTVShowState update({
    List<TVShow>? tvShows,
    StateStatus? status,
    int? page,
    String? errorMessage,
  }) {
    return OnTheAirTVShowState(
      tvShows: tvShows ?? this.tvShows,
      status: status ?? this.status,
      page: page ?? this.page,
      errorMessage: errorMessage,
    );
  }
}
