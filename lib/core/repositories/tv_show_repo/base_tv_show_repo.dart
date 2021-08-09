import '/core/models/tv_show/tv_show.dart';
import '/core/models/tv_show/tv_show_detail.dart';
import '/core/models/tv_show/tv_show_review.dart';

abstract class BaseTVShowRepository {
  Future<List<TVShow>> getTVShowListById(List<int> tvShowIds);
  Future<TVShowDetail> getTVShowDetail(int id);
  Future<List<TVShow>> getOnTheAir({int page = 1});
  Future<List<TVShow>> getPopular({int page = 1});
  Future<List<TVShow>> searchTVShow(String keyword, {int page = 1});
  Future<List<TVShowReview>> getTVShowReviews({
    required int tvShowId,
    int page = 1,
  });

}
