import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';

import '/core/constants/app_apis.dart';
import '/core/helpers/error_handler.dart';
import '/core/models/movie/base_movie.dart';
import '/core/models/movie/movie_detail.dart';
import '/core/models/movie/movie.dart';
import '/core/services/network_service/base_network_service.dart';

import 'base_movies_repo.dart';

class MoviesRepository implements BaseMoviesRepository {
  final BaseNetworkService _networkService;

  MoviesRepository({
    required BaseNetworkService networkService,
  }) : _networkService = networkService;

  final _defaultHeader = const {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  final _defaultParam = {
    AppApis().paramApiKey: AppApis().apiKey,
    AppApis().paramLanguage: AppApis().defaultLanguage,
  };

  @override
  Future<List<Movie>> getMovieListById(List<BaseMovie> movieIds) async {
    final List<Movie> movies = [];

    for (final movie in movieIds) {
      final uri = Uri.https(
        AppApis().baseUrl,
        AppApis().epMovieDetail + movie.id.toString(),
        _defaultParam,
      );
      final response = await _networkService.get(
        uri,
        headers: {
          ..._defaultHeader,
          HttpHeaders.connectionHeader: 'keep-alive',
        },
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
  Future<MovieDetail> getMovieDetail(num? id) async {
    final uri = Uri.https(
      AppApis().baseUrl,
      AppApis().epMovieDetail + id.toString(),
      _defaultParam,
    );
    final response = await _networkService.get(
      uri,
      headers: _defaultHeader,
    );
    if (response.statusCode == 200) {
      String body = response.body;
      return MovieDetail.fromJson(body);
    } else {
      throw ErrorHandler.transformStatusCodeToException(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final now = DateTime.now();
    final date = DateFormat('yyyy-MM-dd').format(now);

    final param = {
      ..._defaultParam,
      AppApis().paramNowPlaying: date,
      AppApis().paramYear: now.year.toString(),
      AppApis().paramPage: page.toString(),
    };

    final uri = Uri.https(AppApis().baseUrl, AppApis().epDiscover, param);
    final response = await _networkService.get(
      uri,
      headers: _defaultHeader,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> map =
          json.decode(response.body) as Map<String, dynamic>;
      final List<Map<String, dynamic>> results = List.from(map['results']);
      return List.generate(results.length, (i) => Movie.fromMap(results[i]));
    } else {
      throw ErrorHandler.transformStatusCodeToException(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final now = DateTime.now().add(Duration(days: 1));
    final date = DateFormat('yyyy-MM-dd').format(now);
    final param = {
      ..._defaultParam,
      AppApis().paramUpcoming: date,
      AppApis().paramPage: page.toString(),
    };
    final uri = Uri.https(AppApis().baseUrl, AppApis().epDiscover, param);
    final response = await _networkService.get(
      uri,
      headers: _defaultHeader,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> map = json.decode(response.body);
      final List<Map<String, dynamic>> results =
          List<Map<String, dynamic>>.from(map['results']);
      return List.generate(results.length, (i) => Movie.fromMap(results[i]));
    } else {
      throw ErrorHandler.transformStatusCodeToException(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }

  @override
  Future<List<Movie>> searchMovie(String keyword, {int page = 1}) async {
    final param = {
      ..._defaultParam,
      AppApis().paramSearch: keyword,
      AppApis().paramPage: page.toString(),
    };

    final uri = Uri.https(AppApis().baseUrl, AppApis().epSearch, param);
    final response = await _networkService.get(
      uri,
      headers: _defaultHeader,
    );

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      final searchResult = jsonMap['results'] as List<Map<String, dynamic>>;
      return List.from(searchResult.map((movie) => Movie.fromMap(movie)));
    } else {
      throw ErrorHandler.transformStatusCodeToException(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }
}
