part of 'fav_eshow_list_cubit.dart';

class FavEShowListState extends BaseBlocState {
  const FavEShowListState({
    required StateStatus status,
    required int currentPage,
    required this.favEShows,
    required bool isAtEndOfPage,
    String? errorMessage,
  }) : super(
          currentPage: currentPage,
          status: status,
          isAtEndOfPage: isAtEndOfPage,
          errorMessage: errorMessage,
        );

  final List<EShow> favEShows;

  factory FavEShowListState.init() {
    return const FavEShowListState(
      status: StateStatus.init,
      currentPage: 0,
      favEShows: [],
      isAtEndOfPage: false,
    );
  }

  FavEShowListState update({
    StateStatus? status,
    List<EShow>? favEShows,
    int? currentPage,
    bool? isAtEndOfPage,
    String? errorMessage,
  }) {
    return FavEShowListState(
      status: status ?? this.status,
      favEShows: favEShows ?? this.favEShows,
      currentPage: currentPage ?? this.currentPage,
      isAtEndOfPage: isAtEndOfPage ?? false,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [...super.props, favEShows];


}
