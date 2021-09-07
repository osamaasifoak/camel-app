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

  @protected
  final Map<Object, List<String>> requests = {};

  @protected
  Future<JsonMap> getRawTVShowDetails({required int tvShowId, Object? requester}) {
    final endpoint = TVEndpoint.details.name + tvShowId.toString();
    final params = AppApis().paramsOf();
    if (requester != null) {
      final String requestUrl = Uri.https(postor.baseUrl, endpoint, params).toString();
      addRequestUrl(
        requester: requester,
        requestUrl: requestUrl,
      );
      return postor.get(endpoint, parameters: params).get<JsonMap>().whenComplete(() {
        removeRequestUrl(
          requester: requester,
          url: requestUrl,
        );
      });
    }
    return postor.get(endpoint, parameters: params).get<JsonMap>();
  }

  @protected
  void addRequestUrl({
    required Object requester,
    required String requestUrl,
  }) {
    requests.update(
      requester,
      (urls) => [...urls, requestUrl],
      ifAbsent: () => [requestUrl],
    );
  }

  @protected
  void removeRequestUrl({
    required Object requester,
    required String url,
  }) {
    requests[requester]!.remove(url);
    if (requests[requester]!.isEmpty) {
      requests.remove(requester);
    }
  }

  @override
  Future<List<TVShow>> fetch({
    required String category,
    int page = 1,
    Object? requester,
  }) async {
    final Map<String, String> params = AppApis().paramsOf(page: page);
    final JsonMap rawTVShows;
    if (requester != null) {
      final String requestUrl = Uri.https(postor.baseUrl, category, params).toString();
      addRequestUrl(
        requester: requester,
        requestUrl: requestUrl,
      );
      rawTVShows = await postor.get(category, parameters: params).get<JsonMap>().whenComplete(() {
        removeRequestUrl(
          requester: requester,
          url: requestUrl,
        );
      });
    } else {
      rawTVShows = await postor.get(category, parameters: params).get<JsonMap>();
    }
    final rawTVShowsList = rawTVShows['results'] as List;
    return rawTVShowsList.map((r) => TVShow.fromMap(r as JsonMap)).toList();
  }

  @override
  Future<TVShowDetail> getDetails({required int id, Object? requester}) async {
    final rawTVShowDetail = await getRawTVShowDetails(
      tvShowId: id,
      requester: requester,
    );
    return TVShowDetail.fromMap(rawTVShowDetail);
  }

  @override
  Future<List<TVShow>> fetchByIds({required List<int> ids, Object? requester}) async {
    final List<TVShow> tvShows = [];

    for (final id in ids) {
      final rawTVShowDetails = await getRawTVShowDetails(
        tvShowId: id,
        requester: requester,
      );
      tvShows.add(TVShow.fromMap(rawTVShowDetails));
    }
    return tvShows;
  }

  @override
  Future<List<TVShowReview>> getReviews({required int id, int page = 1, Object? requester}) async {
    final Map<String, String> params = AppApis().paramsOf(page: page);
    final String tvShowReviewEndpoint = AppApis().tvShowReviewsOf(tvShowId: id);
    final JsonMap rawTVShowReviews;

    if (requester != null) {
      final String requestUrl = Uri.https(postor.baseUrl, tvShowReviewEndpoint, params).toString();
      addRequestUrl(
        requester: requester,
        requestUrl: requestUrl,
      );
      rawTVShowReviews = await postor.get(tvShowReviewEndpoint, parameters: params).get<JsonMap>().whenComplete(() {
        removeRequestUrl(
          requester: requester,
          url: requestUrl,
        );
      });
    } else {
      rawTVShowReviews = await postor.get(tvShowReviewEndpoint, parameters: params).get<JsonMap>();
    }

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

  @override
  void cancelAllRequestsMadeBy(Object requester) {
    if (requests.containsKey(requester)) {
      for (final String requestUrl in requests[requester]!) {
        postor.cancel(requestUrl);
      }
      requests.remove(requester);
    }
  }
}
