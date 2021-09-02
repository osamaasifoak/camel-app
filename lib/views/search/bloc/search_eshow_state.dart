part of 'search_eshow_bloc.dart';

enum EShowType {
  movie,
  tvShow,
}

extension EShowTypeExtension on EShowType {
  String get name {
    switch (index) {
      case 0:
        return 'Movies';
      case 1:
        return 'TV Shows';
      default:
        throw IndexError(
          index,
          EShowType.values.length,
        );
    }
  }

  String get _singletonInstanceName {
    switch (index) {
      case 0:
        return SIName.repo.movies;
      case 1:
        return SIName.repo.tvShows;
      default:
        throw IndexError(
          index,
          EShowType.values.length,
        );
    }
  }
}

class SearchEShowState extends Equatable {
  const SearchEShowState({
    required this.status,
    required this.currentSelectedEShow,
    required this.eShowList,
    required this.searchKeyword,
    required this.page,
    required this.isAtEndOfPage,
    this.errorMessage,
  });

  final StateStatus status;
  final EShowType currentSelectedEShow;
  final List<EShow> eShowList;
  final String searchKeyword;
  final int page;
  final bool isAtEndOfPage;
  final String? errorMessage;

  bool get isLoading => status == StateStatus.loading;
  bool get isLoadingMore => status == StateStatus.loadingMore;
  bool get isBusy => isLoading || isLoadingMore;

  bool get hasError => status == StateStatus.error;

  factory SearchEShowState.init() {
    return const SearchEShowState(
      status: StateStatus.init,
      currentSelectedEShow: EShowType.movie,
      eShowList: [],
      searchKeyword: '',
      page: 1,
      isAtEndOfPage: false,
    );
  }

  SearchEShowState update({
    StateStatus? status,
    EShowType? currentSelectedEShow,
    List<EShow>? eShowList,
    String? searchKeyword,
    int? page,
    bool? isAtEndOfPage,
    String? errorMessage,
  }) {
    return SearchEShowState(
      status: status ?? this.status,
      currentSelectedEShow: currentSelectedEShow ?? this.currentSelectedEShow,
      eShowList: eShowList ?? this.eShowList,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      page: page ?? this.page,
      isAtEndOfPage: isAtEndOfPage ?? false,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        currentSelectedEShow,
        eShowList,
        searchKeyword,
        page,
        isAtEndOfPage,
      ];
}
