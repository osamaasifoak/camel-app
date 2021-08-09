import 'dart:convert' show json;
import 'dart:io' show HttpHeaders;

import 'package:get_it/get_it.dart' show GetIt;
import 'package:meta/meta.dart' show protected;

import '/core/constants/app_apis.dart';
import '/core/helpers/error_handler.dart';
import '/core/models/tv_show/tv_show.dart';
import '/core/models/tv_show/tv_show_detail.dart';
import '/core/models/tv_show/tv_show_review.dart';
import '/core/repositories/tv_show_repo/base_tv_show_repo.dart';
import '/core/services/network_service/base_network_service.dart';

class TVShowRepository implements BaseTVShowRepository {
  TVShowRepository({
    BaseNetworkService? networkService,
  }) : networkService = networkService ?? GetIt.I<BaseNetworkService>();

  @protected
  final BaseNetworkService networkService;

  @protected
  final defaultHeader = const {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  @override
  Future<List<TVShow>> getOnTheAir({int page = 1}) async {
    final uri = AppApis().endpointOf(
      TVEndpoint.onTheAir,
      page: page,
    );
    final response = await networkService.get(
      uri,
      headers: defaultHeader,
    );

    if (response.statusCode == 200) {
      final map = json.decode(response.body) as Map<String, dynamic>;
      final results = map['results'] as List;
      return results.map((r) => TVShow.fromMap(r as Map<String, dynamic>)).toList();
    } else {
      throw ErrorHandler.transformStatusCodeToException(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }

  @override
  Future<List<TVShow>> getPopular({int page = 1}) async {
    final uri = AppApis().endpointOf(
      TVEndpoint.popular,
      page: page,
    );
    final response = await networkService.get(
      uri,
      headers: defaultHeader,
    );

    if (response.statusCode == 200) {
      final map = json.decode(response.body) as Map<String, dynamic>;
      final results = map['results'] as List;
      return results.map((r) => TVShow.fromMap(r as Map<String, dynamic>)).toList();
    } else {
      throw ErrorHandler.transformStatusCodeToException(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }

  @override
  Future<TVShowDetail> getTVShowDetail(int id) async {
    final uri = AppApis().endpointOf(
      TVEndpoint.details,
      id: id.toString(),
    );
    final response = await networkService.get(
      uri,
      headers: defaultHeader,
    );
    if (response.statusCode == 200) {
      return TVShowDetail.fromJson(response.body);
    } else {
      throw ErrorHandler.transformStatusCodeToException(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }

  @override
  Future<List<TVShow>> getTVShowListById(List<int> tvShowIds) async {
    final List<TVShow> tvShows = [];

    for (final id in tvShowIds) {
      final uri = AppApis().endpointOf(
        TVEndpoint.details,
        id: id.toString(),
      );
      final response = await networkService.get(
        uri,
        headers: defaultHeader,
      );
      if (response.statusCode == 200) {
        tvShows.add(TVShow.fromJson(response.body));
      } else {
        throw ErrorHandler.transformStatusCodeToException(
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }
    }
    return tvShows;
  }

  @override
  Future<List<TVShow>> searchTVShow(String keyword, {int page = 1}) async {
    final uri = AppApis().endpointOf(
      TVEndpoint.search,
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
      return searchResult.map((movie) => TVShow.fromMap(movie as Map<String, dynamic>)).toList();
    } else {
      throw ErrorHandler.transformStatusCodeToException(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }

  @override
  Future<List<TVShowReview>> getTVShowReviews({
    required int tvShowId,
    int page = 1,
  }) async {
    final uri = AppApis().endpointOf(
      TVEndpoint.reviews,
      page: page,
      id: tvShowId.toString(),
    );
    final response = await networkService.get(
      uri,
      headers: defaultHeader,
    );

    if (response.statusCode == 200) {
      final map = json.decode(response.body) as Map<String, dynamic>;
      final results = map['results'] as List;
      return results.map((r) => TVShowReview.fromMap(r as Map<String, dynamic>)).toList();
    } else {
      throw ErrorHandler.transformStatusCodeToException(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }
}
