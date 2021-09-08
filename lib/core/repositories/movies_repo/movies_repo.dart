import 'package:flutter/foundation.dart' show protected;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:postor/postor.dart';

import '/core/constants/app_apis.dart';
import '/core/models/movie/movie.dart';
import '/core/models/movie/movie_detail.dart';
import '/core/models/movie/movie_review.dart';
import '../base_eshows_repo.dart';

typedef JsonMap = Map<String, dynamic>;

class MoviesRepository implements BaseEShowsRepository {
  MoviesRepository({
    Postor? postor,
  }) : postor = postor ?? GetIt.I<Postor>();

  @protected
  final Postor postor;

  @protected
  String? lastMovieSearchUrl;

  @protected
  final Map<Object, List<String>> requests = <Object, List<String>>{};

  @protected
  Future<JsonMap> getRawMovieDetails({
    required int movieId,
    Object? requester,
  }) {
    final String endpoint = MovieEndpoint.details.name + movieId.toString();
    final Map<String, String> params = AppApis().paramsOf();
    if (requester != null) {
      final String requestUrl = Uri.https(
        postor.baseUrl,
        endpoint,
        params,
      ).toString();

      addRequestUrl(
        requester: requester,
        requestUrl: requestUrl,
      );

      return postor
          .get(endpoint, parameters: params)
          .get<JsonMap>()
          .whenComplete(
            () => removeRequestUrl(requester: requester, url: requestUrl),
          );
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
      (List<String> urls) => <String>[...urls, requestUrl],
      ifAbsent: () => <String>[requestUrl],
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
  Future<List<Movie>> fetch({
    required String category,
    int page = 1,
    Object? requester,
  }) async {
    final Map<String, String> params = AppApis().paramsOf(page: page);
    final JsonMap rawMovies;
    if (requester != null) {
      final String requestUrl =
          Uri.https(postor.baseUrl, category, params).toString();
      addRequestUrl(
        requester: requester,
        requestUrl: requestUrl,
      );
      rawMovies = await postor
          .get(category, parameters: params)
          .get<JsonMap>()
          .whenComplete(
            () => removeRequestUrl(requester: requester, url: requestUrl),
          );
    } else {
      rawMovies = await postor.get(category, parameters: params).get<JsonMap>();
    }
    final List<dynamic> rawMoviesList = rawMovies['results'] as List<dynamic>;
    return rawMoviesList
        .map((dynamic r) => Movie.fromMap(r as JsonMap))
        .toList();
  }

  @override
  Future<List<Movie>> fetchByIds({
    required List<int> ids,
    Object? requester,
  }) async {
    final List<Movie> movies = <Movie>[];

    for (final int id in ids) {
      final JsonMap rawMovieDetails = await getRawMovieDetails(
        movieId: id,
        requester: requester,
      );
      movies.add(Movie.fromMap(rawMovieDetails));
    }
    return movies;
  }

  @override
  Future<MovieDetail> getDetails({required int id, Object? requester}) async {
    final JsonMap rawMovieDetails = await getRawMovieDetails(
      movieId: id,
      requester: requester,
    );
    return MovieDetail.fromMap(rawMovieDetails);
  }

  @override
  Future<List<MovieReview>> getReviews({
    required int id,
    int page = 1,
    Object? requester,
  }) async {
    final Map<String, String> params = AppApis().paramsOf(page: page);
    final String movieReviewEndpoint = AppApis().movieReviewsOf(movieId: id);
    final JsonMap rawMovieReviews;

    if (requester != null) {
      final String requestUrl =
          Uri.https(postor.baseUrl, movieReviewEndpoint, params).toString();
      addRequestUrl(
        requester: requester,
        requestUrl: requestUrl,
      );
      rawMovieReviews = await postor
          .get(movieReviewEndpoint, parameters: params)
          .get<JsonMap>()
          .whenComplete(() {
        removeRequestUrl(
          requester: requester,
          url: requestUrl,
        );
      });
    } else {
      rawMovieReviews = await postor
          .get(movieReviewEndpoint, parameters: params)
          .get<JsonMap>();
    }

    final List<dynamic> rawMovieReviewsList =
        rawMovieReviews['results'] as List<dynamic>;

    return rawMovieReviewsList
        .map((dynamic r) => MovieReview.fromMap(r as JsonMap))
        .toList();
  }

  @override
  Future<List<Movie>> search({required String keyword, int page = 1}) async {
    final String endpoint = MovieEndpoint.search.name;
    final Map<String, String> params = AppApis().paramsOf(
      page: page,
      searchKeyword: keyword,
    );
    lastMovieSearchUrl = Uri.https(postor.baseUrl, endpoint, params).toString();
    final Map<String, dynamic> rawSearchResult = await postor
        .get(endpoint, parameters: params)
        .get<JsonMap>()
        .whenComplete(() => lastMovieSearchUrl = null);

    final List<dynamic> rawSearchResultList =
        rawSearchResult['results'] as List<dynamic>;

    return rawSearchResultList
        .map((dynamic movie) => Movie.fromMap(movie as JsonMap))
        .toList();
  }

  @override
  void cancelLastSearch() {
    if (lastMovieSearchUrl != null) {
      postor.cancel(lastMovieSearchUrl!);
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
