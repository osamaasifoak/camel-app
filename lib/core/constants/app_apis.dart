import 'package:flutter/services.dart' show rootBundle;

const String kDefaultLanguage = 'en-US';
const String kDefaultRegion = 'US';

enum MovieEndpoint {
  details,
  search,
  nowPlaying,
  upcoming,
  popular,
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
  final String epThumbImage = '/t/p/w300';
  final String epOriginalImage = '/t/p/original';

  final String baseUrl = 'api.themoviedb.org';

  final String _paramApiKey = 'api_key';
  final String _paramLanguage = 'language';
  final String _paramRegion = 'region';

  final String _paramPage = 'page';
  final String _paramSearchKeyword = 'query';

  final Map<String, String> defaultHeader = const {
    'Content-Type': 'application/json',
  };

  late final String _cachedApiKey;

  Future<void> loadApiKey({String? apiKey}) async {
    _cachedApiKey = apiKey ??
        await rootBundle.loadString(
          'assets/apikey.txt',
          cache: false,
        );
  }

  String movieReviewsOf({
    required final int movieId,
  }) {
    return '/3/movie/$movieId/reviews';
  }

  String tvShowReviewsOf({
    required final int tvShowId,
  }) {
    return '/3/tv/$tvShowId/reviews';
  }

  Map<String, String> paramsOf({
    final int? page,
    final String? searchKeyword,
    final String language = kDefaultLanguage,
    final String region = kDefaultRegion,
  }) {
    final Map<String, String> params = {
      _paramApiKey: _cachedApiKey,
      _paramLanguage: language,
      _paramRegion: region,
      if (page != null) _paramPage: page.toString(),
      if (searchKeyword != null) _paramSearchKeyword: searchKeyword,
    };
    return params;
  }
}
