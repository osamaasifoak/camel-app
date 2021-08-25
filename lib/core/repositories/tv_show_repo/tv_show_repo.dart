import 'package:get_it/get_it.dart' show GetIt;
import 'package:meta/meta.dart' show protected;
import 'package:postor/postor.dart';

import '/core/constants/app_apis.dart';
import '/core/models/tv_show/tv_show.dart';
import '/core/models/tv_show/tv_show_detail.dart';
import '/core/models/tv_show/tv_show_review.dart';
import '/core/repositories/tv_show_repo/base_tv_show_repo.dart';

typedef JsonMap = Map<String, dynamic>;

class TVShowRepository implements BaseTVShowRepository {
  TVShowRepository({
    Postor? postor,
  }) : postor = postor ?? GetIt.I<Postor>();

  @protected
  final Postor postor;

  @override
  Future<List<TVShow>> getOnTheAir({int page = 1}) async {
    final endpoint = TVEndpoint.onTheAir.name;
    final params = AppApis().paramsOf(page: page);
    final rawOnTheAir = await postor.get(endpoint, parameters: params).get<JsonMap>();

    final rawOnTheAirList = rawOnTheAir['results'] as List;
    return rawOnTheAirList.map((r) => TVShow.fromMap(r as JsonMap)).toList();
  }

  @override
  Future<List<TVShow>> getPopular({int page = 1}) async {
    final endpoint = TVEndpoint.popular.name;
    final params = AppApis().paramsOf(page: page);
    final rawPopular = await postor.get(endpoint, parameters: params).get<JsonMap>();

    final rawPopularList = rawPopular['results'] as List;
    return rawPopularList.map((r) => TVShow.fromMap(r as JsonMap)).toList();
  }

  @override
  Future<TVShowDetail> getTVShowDetail(int id) async {
    final endpoint = TVEndpoint.details.name + id.toString();
    final params = AppApis().paramsOf();
    final rawTVShowDetail = await postor.get(endpoint, parameters: params).get<JsonMap>();

    return TVShowDetail.fromMap(rawTVShowDetail);
  }

  @override
  Future<List<TVShow>> getTVShowListById(List<int> tvShowIds) async {
    final List<TVShow> tvShows = [];

    for (final id in tvShowIds) {
      final endpoint = TVEndpoint.details.name + id.toString();
      final params = AppApis().paramsOf();
      final rawTVShowDetails = await postor.get(endpoint, parameters: params).get<JsonMap>();

      tvShows.add(TVShow.fromMap(rawTVShowDetails));
    }
    return tvShows;
  }

  @override
  Future<List<TVShow>> searchTVShow(String keyword, {int page = 1}) async {
    final endpoint = TVEndpoint.search.name;
    final params = AppApis().paramsOf(
      page: page,
      searchKeyword: keyword,
    );
    final rawSearchResult = await postor.get(endpoint, parameters: params).get<JsonMap>();

    final rawSearchResultList = rawSearchResult['results'] as List;
    return rawSearchResultList.map((tvShow) => TVShow.fromMap(tvShow as JsonMap)).toList();
  }

  @override
  Future<List<TVShowReview>> getTVShowReviews({required int tvShowId, int page = 1}) async {
    final params = AppApis().paramsOf(page: page);
    final tvShowReviewEndpoint = AppApis().tvShowReviewsOf(tvShowId: tvShowId);
    final rawTVShowReviews = await postor.get(tvShowReviewEndpoint, parameters: params).get<JsonMap>();

    final rawTVShowReviewsList = rawTVShowReviews['results'] as List;
    return rawTVShowReviewsList.map((r) => TVShowReview.fromMap(r as JsonMap)).toList();
  }
}
