import 'package:flutter/services.dart' show rootBundle;

const String kDefaultLanguage = 'en-US';
const String kDefaultRegion = 'US';

enum MovieEndpoint {
  details,
  search,
  nowPlaying,
  upcoming,
  popular,
  reviews,
}

extension MovieEndpointName on MovieEndpoint {
  String get name {
    switch (index) {
      case 0:
        return '/3/movie/';
      case 1:
        return '/3/search/movie';
      case 2:
        return '/3/movie/now_playing';
      case 3:
        return '/3/movie/upcoming';
      case 4:
        return '/3/movie/popular';
      case 5:
        return '/3/movie/<movieId>/reviews';
      default:
        throw IndexError(
          index,
          MovieEndpoint.values.length,
        );
    }
  }
}

enum TVEndpoint {
  onTheAir,
  popular,
  details,
  search,
  reviews,
}

extension TVEndpointName on TVEndpoint {
  String get name {
    switch (index) {
      case 0:
        return '/3/tv/on_the_air';
      case 1:
        return '/3/tv/popular';
      case 2:
        return '/3/tv/';
      case 3:
        return '/3/search/tv';
      case 4:
        return '/3/tv/<tvId>/reviews';
      default:
        throw IndexError(
          index,
          TVEndpoint.values.length,
        );
    }
  }
}

/// (Movie)
/// Details:
///
/// https://api.themoviedb.org/3/movie/[id]?api_key=[apiKey]&language=en-US
///
/// example:
///
/// ```dart
/// final uri = AppApis().endpointOf(
///   MovieEndpoint.details,
///   id: 'id',
/// );
/// ```
///
/// (Movie)
/// Search:
///
/// https://api.themoviedb.org/3/search/movie?api_key=[apiKey]&language=en-US&page=[page]
///
/// example:
///
/// ```dart
/// final uri = AppApis().endpointOf(
///   MovieEndpoint.search,
///   page: 1,
///   keyword: 'keyword',
/// );
/// ```
///
/// (Movie)
/// Now Playing / Upcoming / Popular:
///
/// https://api.themoviedb.org/3/movie/now_playing_or_upcoming_or_popular?api_key=[apiKey]&language=en-US&page=[page]
///
/// example:
///
/// ```dart
/// final uri = AppApis().endpointOf(
///   MovieEndpoint.nowPlaying,
///   page: 1,
/// );
/// ```
///
/// (TV)
/// Details:
///
/// https://api.themoviedb.org/3/tv/[id]?api_key=[apiKey]&language=en-US
///
/// example:
///
/// ```dart
/// final uri = AppApis().endpointOf(
///   TVEndpoint.details,
///   id: 'id',
/// );
/// ```
///
/// (TV)
/// On The Air / Popular:
///
/// https://api.themoviedb.org/3/tv/on_the_air__or__popular?api_key=[apiKey]&language=en-US&page=[page]
///
/// example:
///
/// ```dart
/// final uri = AppApis().endpointOf(
///   TVEndpoint.onTheAir,
///   page: 1,
/// );
/// ```
class AppApis {
  factory AppApis() => _singleton;

  static final AppApis _singleton = AppApis._internal();

  AppApis._internal();

  final String baseImageUrl = 'https://image.tmdb.org';
  final String epThumbImage = '/t/p/w500';
  final String epOriginalImage = '/t/p/original';

  final String _baseUrl = 'api.themoviedb.org';

  final String _paramApiKey = 'api_key';
  final String _paramLanguage = 'language';
  final String _paramRegion = 'region';

  final String _paramPage = 'page';
  final String _paramSearchKeyword = 'query';

  late final String _cachedApiKey;

  Future<void> loadApiKey({String? apiKey}) async {
    _cachedApiKey = apiKey ??
        await rootBundle.loadString(
          'assets/apikey.txt',
          cache: false,
        );
  }

  /// [endpoint] get either [MovieEndpoint] or [TVEndpoint] endpoint
  ///
  /// [page] is used for:
  /// * [MovieEndpoint.nowPlaying]
  /// * [MovieEndpoint.upcoming]
  /// * [MovieEndpoint.popular]
  /// * [MovieEndpoint.search]
  ///
  /// [id] can be `movieId` or `tvId` depends on [endpoint]
  /// and is used for [MovieEndpoint.details]
  ///
  /// [keyword] is used for [MovieEndpoint.search]
  ///
  /// [language] pass an ISO 639-1 value to display translated data for the fields that support it.
  /// defaults to [kDefaultLanguage] `en-US`
  ///
  /// [region] specify a ISO 3166-1 code to filter release dates. Must be uppercase.
  /// defaults to [kDefaultRegion] `US`
  Uri endpointOf(
    Object endpoint, {
    int? page,
    String? id,
    String? keyword,
    String language = kDefaultLanguage,
    String region = kDefaultRegion,
  }) {
    if (endpoint is MovieEndpoint) {
      return _movieEndpointOf(
        endpoint,
        page: page,
        keyword: keyword,
        movieId: id,
        language: language,
        region: region,
      );
    } else if (endpoint is TVEndpoint) {
      return _tvEndpointOf(
        endpoint,
        page: page,
        keyword: keyword,
        tvId: id,
        language: language,
        region: region,
      );
    }

    throw ArgumentError('You have to choose between Movie or TV endpoint');
  }

  Uri _movieEndpointOf(
    MovieEndpoint endpoint, {
    required String language,
    required String region,
    int? page,
    String? keyword,
    String? movieId,
  }) {
    final String endpointName;
    final params = {
      _paramApiKey: _cachedApiKey,
      _paramLanguage: language,
      _paramRegion: region,
    };
    switch (endpoint) {
      case MovieEndpoint.nowPlaying:
      case MovieEndpoint.upcoming:
      case MovieEndpoint.popular:
      case MovieEndpoint.search:
        assert(
          movieId == null,
          "Don't set [movieId] if not needed",
        );
        params[_paramPage] = page!.toString();
        if (endpoint == MovieEndpoint.search) {
          params[_paramSearchKeyword] = keyword!;
        }
        endpointName = endpoint.name;
        break;
      case MovieEndpoint.details:
        assert(
          page == null && keyword == null,
          "Don't set [page] and [keyword] if not needed",
        );
        endpointName = endpoint.name + movieId!;
        break;
      case MovieEndpoint.reviews:
        assert(
          keyword == null,
          "Don't set [keyword] if not needed",
        );
        params[_paramPage] = page!.toString();
        endpointName = endpoint.name.replaceFirst(
          '<movieId>',
          movieId!,
        );
        break;
    }
    return Uri.https(
      _baseUrl,
      endpointName,
      params,
    );
  }

  Uri _tvEndpointOf(
    TVEndpoint endpoint, {
    required String language,
    required String region,
    int? page,
    String? keyword,
    String? tvId,
  }) {
    final String endpointName;
    final params = {
      _paramApiKey: _cachedApiKey,
      _paramLanguage: language,
      _paramRegion: region,
    };
    switch (endpoint) {
      case TVEndpoint.popular:
      case TVEndpoint.onTheAir:
      case TVEndpoint.search:
        assert(
          tvId == null,
          "Don't set [tvId] if not needed",
        );
        params[_paramPage] = page!.toString();
        if (endpoint == TVEndpoint.search) {
          params[_paramSearchKeyword] = keyword!;
        }
        endpointName = endpoint.name;
        break;
      case TVEndpoint.details:
        assert(
          page == null && keyword == null,
          "Don't set [page] and [keyword] if not needed",
        );
        endpointName = endpoint.name + tvId!;
        break;
      case TVEndpoint.reviews:
        assert(
          keyword == null,
          "Don't set [keyword] if not needed",
        );
        params[_paramPage] = page!.toString();
        endpointName = endpoint.name.replaceFirst(
          '<tvId>',
          tvId!,
        );
        break;
    }
    return Uri.https(
      _baseUrl,
      endpointName,
      params,
    );
  }
}
