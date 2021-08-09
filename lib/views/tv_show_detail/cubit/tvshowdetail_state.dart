part of 'tvshowdetail_cubit.dart';

abstract class TVShowDetailState extends Equatable {
  const TVShowDetailState();

  @override
  List<Object?> get props => const [];
}

class TVShowDetailLoading extends TVShowDetailState {
  const TVShowDetailLoading();
}

class TVShowDetailError extends TVShowDetailState {
  final String errorMessage;
  const TVShowDetailError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class TVShowDetailLoaded extends TVShowDetailState {
  final TVShowDetail tvShowDetail;
  final List<TVShowReview> tvShowReviews;
  final bool isFavTV;

  const TVShowDetailLoaded({
    required this.tvShowDetail,
    required this.tvShowReviews,
    required this.isFavTV,
  });

  TVShowDetailLoaded update({
    TVShowDetail? tvShowDetail,
    List<TVShowReview>? tvShowReviews,
    bool? isFavTV,
  }) {
    return TVShowDetailLoaded(
      tvShowDetail: tvShowDetail ?? this.tvShowDetail,
      tvShowReviews: tvShowReviews ?? this.tvShowReviews,
      isFavTV: isFavTV ?? this.isFavTV,
    );
  }

  @override
  List<Object> get props => [tvShowDetail, isFavTV, tvShowReviews];
}
