part of 'populartvshow_cubit.dart';

class PopularTVShowState extends BaseTVShowListState {
  const PopularTVShowState({
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

  factory PopularTVShowState.init() {
    return const PopularTVShowState(
      status: StateStatus.init,
      tvShows: [],
      page: 0,
    );
  }

  @override
  PopularTVShowState update({
    List<TVShow>? tvShows,
    StateStatus? status,
    int? page,
    String? errorMessage,
  }) {
    return PopularTVShowState(
      tvShows: tvShows ?? this.tvShows,
      status: status ?? this.status,
      page: page ?? this.page,
      errorMessage: errorMessage,
    );
  }
}
