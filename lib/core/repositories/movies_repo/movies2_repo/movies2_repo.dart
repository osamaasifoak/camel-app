import 'dart:convert' show json;

import '../movies_repo.dart';
import '/core/constants/app_apis.dart';
import '/core/helpers/error_handler.dart';
import '/core/models/movie/movie.dart';
import '/core/models/movie/movie_review.dart';
import '/core/services/network_service/base_network_service.dart';
import 'base_movies2_repo.dart';

class Movies2Repository extends MoviesRepository implements BaseMovies2Repository {
  Movies2Repository({
    BaseNetworkService? networkService,
  }) : super(networkService: networkService);

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final uri = AppApis().endpointOf(
      MovieEndpoint.popular,
      page: page,
    );
    final response = await networkService.get(
      uri,
      headers: defaultHeader,
    );

    if (response.statusCode == 200) {
      final map = json.decode(response.body) as Map<String, dynamic>;
      final results = map['results'] as List;
      return results.map((r) => Movie.fromMap(r as Map<String, dynamic>)).toList();
    } else {
      throw ErrorHandler.transformStatusCodeToException(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }

  @override
  Future<List<MovieReview>> getMovieReviews({
    required int movieId,
    int page = 1,
  }) async {
    final uri = AppApis().endpointOf(
      MovieEndpoint.reviews,
      page: page,
      id: movieId.toString(),
    );
    final response = await networkService.get(
      uri,
      headers: defaultHeader,
    );

    if (response.statusCode == 200) {
      final map = json.decode(response.body) as Map<String, dynamic>;
      final results = map['results'] as List;
      return results.map((r) => MovieReview.fromMap(r as Map<String, dynamic>)).toList();
    } else {
      throw ErrorHandler.transformStatusCodeToException(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }
}
