import 'dart:convert' show json;
import 'dart:io' show HttpHeaders;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:meta/meta.dart' show protected;

import '/core/constants/app_apis.dart';
import '/core/helpers/error_handler.dart';
import '/core/models/movie/movie.dart';
import '/core/models/movie/movie_detail.dart';
import '/core/services/network_service/base_network_service.dart';

import 'base_movies_repo.dart';

class MoviesRepository implements BaseMoviesRepository {
  
  MoviesRepository({
    BaseNetworkService? networkService,
  }) : networkService = networkService ?? GetIt.I<BaseNetworkService>();

  @protected
  final BaseNetworkService networkService;

  @protected
  final defaultHeader = const {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  @override
  Future<List<Movie>> getMovieListById(List<int> movieIds) async {
    final List<Movie> movies = [];

    for (final id in movieIds) {
      final uri = AppApis().endpointOf(
        MovieEndpoint.details,
        id: id.toString(),
      );
      final response = await networkService.get(
        uri,
        headers: defaultHeader,
      );
      if (response.statusCode == 200) {
        movies.add(Movie.fromJson(response.body));
      } else {
        throw ErrorHandler.transformStatusCodeToException(
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }
    }
    return movies;
  }

  @override
  Future<MovieDetail> getMovieDetail(int id) async {
    final uri = AppApis().endpointOf(
      MovieEndpoint.details,
      id: id.toString(),
    );
    final response = await networkService.get(
      uri,
      headers: defaultHeader,
    );
    if (response.statusCode == 200) {
      return MovieDetail.fromJson(response.body);
    } else {
      throw ErrorHandler.transformStatusCodeToException(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final uri = AppApis().endpointOf(
      MovieEndpoint.nowPlaying,
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
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final uri = AppApis().endpointOf(
      MovieEndpoint.upcoming,
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
  Future<List<Movie>> searchMovie(String keyword, {int page = 1}) async {

    final uri = AppApis().endpointOf(
      MovieEndpoint.search,
      page: page,
      keyword: keyword,
    );

    final response = await networkService.get(
      uri,
      headers: defaultHeader,
    );

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      final searchResult = jsonMap['results'] as List;
      return searchResult.map((movie) => Movie.fromMap(movie as Map<String, dynamic>)).toList();
    } else {
      throw ErrorHandler.transformStatusCodeToException(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }
}

