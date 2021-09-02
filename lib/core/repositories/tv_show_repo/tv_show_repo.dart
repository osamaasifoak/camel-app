import 'package:get_it/get_it.dart' show GetIt;
import 'package:meta/meta.dart' show protected;
import 'package:postor/postor.dart';

import '../base_eshows_repo.dart';
import '/core/constants/app_apis.dart';
import '/core/models/tv_show/tv_show.dart';
import '/core/models/tv_show/tv_show_detail.dart';
import '/core/models/tv_show/tv_show_review.dart';

typedef JsonMap = Map<String, dynamic>;

class TVShowRepository implements BaseEShowsRepository {
  TVShowRepository({
    Postor? postor,
  }) : postor = postor ?? GetIt.I<Postor>();

  @protected
  final Postor postor;

  @protected
  String? lastTVShowSearchUrl;

  @override
  Future<List<TVShow>> fetch({
    required String category,
    int page = 1,
  }) async {
    final params = AppApis().paramsOf(page: page);
    final rawTVShows = await postor.get(category, parameters: params).get<JsonMap>();

    final rawTVShowsList = rawTVShows['results'] as List;
    return rawTVShowsList.map((r) => TVShow.fromMap(r as JsonMap)).toList();
  }

  @protected
  Future<JsonMap> getRawTVShowDetails({required int tvShowId}) {
    final endpoint = TVEndpoint.details.name + tvShowId.toString();
    final params = AppApis().paramsOf();
    return postor.get(endpoint, parameters: params).get<JsonMap>();
  }
  @override
  Future<TVShowDetail> getDetails({required int id}) async {
    final rawTVShowDetail = await getRawTVShowDetails(tvShowId: id);
    return TVShowDetail.fromMap(rawTVShowDetail);
  }

  @override
  Future<List<TVShow>> fetchByIds({required List<int> ids}) async {
    final List<TVShow> tvShows = [];

    for (final id in ids) {
      final rawTVShowDetails = await getRawTVShowDetails(tvShowId: id);
      tvShows.add(TVShow.fromMap(rawTVShowDetails));
    }
    return tvShows;
  }

  @override
  Future<List<TVShowReview>> getReviews({required int id, int page = 1}) async {
    final params = AppApis().paramsOf(page: page);
    final tvShowReviewEndpoint = AppApis().tvShowReviewsOf(tvShowId: id);
    final rawTVShowReviews = await postor.get(tvShowReviewEndpoint, parameters: params).get<JsonMap>();

    final rawTVShowReviewsList = rawTVShowReviews['results'] as List;
    return rawTVShowReviewsList.map((r) => TVShowReview.fromMap(r as JsonMap)).toList();
  }

  @override
  Future<List<TVShow>> search({required String keyword, int page = 1}) async {
    final endpoint = TVEndpoint.search.name;
    final params = AppApis().paramsOf(
      page: page,
      searchKeyword: keyword,
    );
    cancelLastSearch();
    lastTVShowSearchUrl = Uri.https(postor.baseUrl, endpoint, params).toString();
    final rawSearchResult = await postor.get(endpoint, parameters: params).get<JsonMap>().whenComplete(() {
      lastTVShowSearchUrl = null;
    });

    final rawSearchResultList = rawSearchResult['results'] as List;
    return rawSearchResultList.map((tvShow) => TVShow.fromMap(tvShow as JsonMap)).toList();
  }

  @override
  void cancelLastSearch() {
    if (lastTVShowSearchUrl != null) {
      postor.cancel(lastTVShowSearchUrl!);
    }
  }
}
