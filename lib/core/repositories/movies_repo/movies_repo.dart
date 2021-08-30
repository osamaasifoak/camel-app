import 'package:get_it/get_it.dart' show GetIt;
import 'package:meta/meta.dart' show protected;
import 'package:postor/postor.dart';

import '/core/constants/app_apis.dart';
import '/core/models/movie/movie.dart';
import '/core/models/movie/movie_detail.dart';
import '/core/models/movie/movie_review.dart';
import 'base_movies_repo.dart';

typedef JsonMap = Map<String, dynamic>;

class MoviesRepository implements BaseMoviesRepository {
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

  @protected
  Future<List<Movie>> getMovies({
    required MovieEndpoint movieEndpoint,
    required int page,
  }) async {
    final params = AppApis().paramsOf(page: page);
    final rawMovies = await postor.get(movieEndpoint.name, parameters: params).get<JsonMap>();

    final rawMoviesList = rawMovies['results'] as List;
    return rawMoviesList.map((r) => Movie.fromMap(r as JsonMap)).toList();
  }

  @override
  Future<List<Movie>> getMovieListById(List<int> movieIds) async {
    final List<Movie> movies = [];

    for (final int id in movieIds) {
      final rawMovieDetails = await getRawMovieDetails(movieId: id);
      movies.add(Movie.fromMap(rawMovieDetails));
    }
    return movies;
  }

  @override
  Future<MovieDetail> getMovieDetail(int id) async {
    final rawMovieDetails = await getRawMovieDetails(movieId: id);
    return MovieDetail.fromMap(rawMovieDetails);
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return getMovies(movieEndpoint: MovieEndpoint.nowPlaying, page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return getMovies(movieEndpoint: MovieEndpoint.upcoming, page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return getMovies(movieEndpoint: MovieEndpoint.popular, page: page);
  }

  @override
  Future<List<MovieReview>> getMovieReviews({required int movieId, int page = 1}) async {
    final params = AppApis().paramsOf(page: page);
    final movieReviewEndpoint = AppApis().movieReviewsOf(movieId: movieId);
    final rawMovieReviews = await postor.get(movieReviewEndpoint, parameters: params).get<JsonMap>();

    final rawMovieReviewsList = rawMovieReviews['results'] as List;
    return rawMovieReviewsList.map((r) => MovieReview.fromMap(r as JsonMap)).toList();
  }

  @override
  Future<List<Movie>> searchMovie({required String keyword, int page = 1}) async {
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
  void cancelLastMovieSearch() {
    if (lastMovieSearchUrl != null) {
      postor.cancel(lastMovieSearchUrl!);
    }
  }
}
