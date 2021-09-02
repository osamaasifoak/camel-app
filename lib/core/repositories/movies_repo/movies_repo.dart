import 'package:get_it/get_it.dart' show GetIt;
import 'package:meta/meta.dart' show protected;
import 'package:postor/postor.dart';

import '../base_eshows_repo.dart';
import '/core/constants/app_apis.dart';
import '/core/models/movie/movie.dart';
import '/core/models/movie/movie_detail.dart';
import '/core/models/movie/movie_review.dart';

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
  Future<JsonMap> getRawMovieDetails({required int movieId}) {
    final endpoint = MovieEndpoint.details.name + movieId.toString();
    final params = AppApis().paramsOf();
    return postor.get(endpoint, parameters: params).get<JsonMap>();
  }

  @override
  Future<List<Movie>> fetch({
    required String category,
    int page = 1,
  }) async {
    final params = AppApis().paramsOf(page: page);
    final rawMovies = await postor.get(category, parameters: params).get<JsonMap>();

    final rawMoviesList = rawMovies['results'] as List;
    return rawMoviesList.map((r) => Movie.fromMap(r as JsonMap)).toList();
  }

  @override
  Future<List<Movie>> fetchByIds({required List<int> ids}) async {
    final List<Movie> movies = [];

    for (final int id in ids) {
      final rawMovieDetails = await getRawMovieDetails(movieId: id);
      movies.add(Movie.fromMap(rawMovieDetails));
    }
    return movies;
  }

  @override
  Future<MovieDetail> getDetails({required int id}) async {
    final rawMovieDetails = await getRawMovieDetails(movieId: id);
    return MovieDetail.fromMap(rawMovieDetails);
  }

  @override
  Future<List<MovieReview>> getReviews({required int id, int page = 1}) async {
    final params = AppApis().paramsOf(page: page);
    final movieReviewEndpoint = AppApis().movieReviewsOf(movieId: id);
    final rawMovieReviews = await postor.get(movieReviewEndpoint, parameters: params).get<JsonMap>();

    final rawMovieReviewsList = rawMovieReviews['results'] as List;
    return rawMovieReviewsList.map((r) => MovieReview.fromMap(r as JsonMap)).toList();
  }

  @override
  Future<List<Movie>> search({required String keyword, int page = 1}) async {
    final endpoint = MovieEndpoint.search.name;
    final params = AppApis().paramsOf(
      page: page,
      searchKeyword: keyword,
    );
    lastMovieSearchUrl = Uri.https(postor.baseUrl, endpoint, params).toString();
    final rawSearchResult = await postor.get(endpoint, parameters: params).get<JsonMap>().whenComplete(() {
      lastMovieSearchUrl = null;
    });

    final rawSearchResultList = rawSearchResult['results'] as List;
    return rawSearchResultList.map((movie) => Movie.fromMap(movie as JsonMap)).toList();
  }

  @override
  void cancelLastSearch() {
    if (lastMovieSearchUrl != null) {
      postor.cancel(lastMovieSearchUrl!);
    }
  }
}
