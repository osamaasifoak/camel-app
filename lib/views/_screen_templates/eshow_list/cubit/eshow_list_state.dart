part of 'eshow_list_cubit.dart';

class EShowListState extends BaseBlocState {
  const EShowListState({
    required this.eShows,
    required StateStatus status,
    required int currentPage,
    required bool isAtEndOfPage,
    String? errorMessage,
  }) : super(
          status: status,
          currentPage: currentPage,
          isAtEndOfPage: isAtEndOfPage,
          errorMessage: errorMessage,
        );

  final List<EShow> eShows;

  factory EShowListState.init() {
    return const EShowListState(
      status: StateStatus.init,
      eShows: [],
      currentPage: 0,
      isAtEndOfPage: false,
    );
  }

  EShowListState update({
    List<EShow>? eShows,
    StateStatus? status,
    int? currentPage,
    bool? isAtEndOfPage,
    String? errorMessage,
  }) {
    return EShowListState(
      eShows: eShows ?? this.eShows,
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      isAtEndOfPage: isAtEndOfPage ?? false,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [...super.props, eShows];
}
