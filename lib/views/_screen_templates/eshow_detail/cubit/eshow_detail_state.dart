part of 'eshow_detail_cubit.dart';

enum EShowDetailStatus {
  loading,
  loaded,
  error,
}

class EShowDetailState extends Equatable {
  const EShowDetailState({
    required this.status,
    required this.eShowDetails,
    required this.eShowReviews,
    required this.isFav,
    this.errorMessage,
  });

  final EShowDetailStatus status;
  final EShowDetails? eShowDetails;
  final List<EShowReview> eShowReviews;
  final bool isFav;
  final String? errorMessage;

  bool get isLoading => status == EShowDetailStatus.loading;
  bool get isLoaded => status == EShowDetailStatus.loaded;
  bool get hasError => status == EShowDetailStatus.error;

  factory EShowDetailState.init() {
    return const EShowDetailState(
      status: EShowDetailStatus.loading,
      eShowDetails: null,
      eShowReviews: [],
      isFav: false,
    );
  }

  EShowDetailState update({
    EShowDetailStatus? status,
    EShowDetails? eShowDetails,
    List<EShowReview>? eShowReviews,
    bool? isFav,
    String? errorMessage,
  }) {
    return EShowDetailState(
      status: status ?? this.status,
      eShowDetails: eShowDetails ?? this.eShowDetails,
      eShowReviews: eShowReviews ?? this.eShowReviews,
      isFav: isFav ?? this.isFav,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, eShowDetails, eShowReviews, isFav];
}
