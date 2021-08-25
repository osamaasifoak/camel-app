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

  @override
  Future<List<Movie>> getMovieListById(List<int> movieIds) async {
    final List<Movie> movies = [];

    for (final id in movieIds) {
      final endpoint = MovieEndpoint.details.name + id.toString();
      final params = AppApis().paramsOf();
      final rawMovieDetails = await postor.get(endpoint, parameters: params).get<JsonMap>();

      movies.add(Movie.fromMap(rawMovieDetails));
    }
    return movies;
  }

  @override
  Future<MovieDetail> getMovieDetail(int id) async {
    final endpoint = MovieEndpoint.details.name + id.toString();
    final params = AppApis().paramsOf();
    final rawMovieDetails = await postor.get(endpoint, parameters: params).get<JsonMap>();

    return MovieDetail.fromMap(rawMovieDetails);
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final endpoint = MovieEndpoint.nowPlaying.name;
    final params = AppApis().paramsOf(page: page);
    final rawNowPlaying = await postor.get(endpoint, parameters: params).get<JsonMap>();

    final rawNowPlayingList = rawNowPlaying['results'] as List;
    return rawNowPlayingList.map((r) => Movie.fromMap(r as JsonMap)).toList();
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final endpoint = MovieEndpoint.upcoming.name;
    final params = AppApis().paramsOf(page: page);
    final rawUpcoming = await postor.get(endpoint, parameters: params).get<JsonMap>();

    final rawUpcomingList = rawUpcoming['results'] as List;
    return rawUpcomingList.map((r) => Movie.fromMap(r as JsonMap)).toList();
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final endpoint = MovieEndpoint.popular.name;
    final params = AppApis().paramsOf(page: page);
    final rawPopular = await postor.get(endpoint, parameters: params).get<JsonMap>();

    final rawPopularList = rawPopular['results'] as List;
    return rawPopularList.map((r) => Movie.fromMap(r as JsonMap)).toList();
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
  Future<List<Movie>> searchMovie(String keyword, {int page = 1}) async {
    final endpoint = MovieEndpoint.search.name;
    final params = AppApis().paramsOf(
      page: page,
      searchKeyword: keyword,
    );
    final rawSearchResult = await postor.get(endpoint, parameters: params).get<JsonMap>();

    final rawSearchResultList = rawSearchResult['results'] as List;
    return rawSearchResultList.map((movie) => Movie.fromMap(movie as JsonMap)).toList();
  }
}
