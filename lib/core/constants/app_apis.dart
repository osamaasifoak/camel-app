import 'package:flutter/services.dart' show rootBundle;

///Movie Detail:
///
///https://api.themoviedb.org/3/movie/[MovieID]?api_key=[apiKey]&language=en-US
///
///```dart
///example:
///Uri.https(AppApis().baseUrl, AppApis().epMovieDetail + [id], {
/// AppApis().paramApiKey: AppApis().apiKey,
/// AppApis().paramLanguage: AppApis().defaultLanguage,
///});
///```
///
///Discover:
///
///https://api.themoviedb.org/3/discover/movie?api_key=[apiKey]&language=en-US
///
///example:
///
///```dart
///Uri.https(AppApis().baseUrl, AppApis().epDiscover, {
/// AppApis().paramApiKey: AppApis().apiKey,
/// AppApis().paramLanguage: AppApis().defaultLanguage,
/// AppApis().paramNowPlaying: [yyyy-MM-dd],
/// AppApis().paramYear: [yyyy],
/// AppApis().paramPage: [page],
///});
///```
///
///
///Search:
///
///https://api.themoviedb.org/3/search/movie?api_key=[apiKey]&language=en-US
///
///example:
///
///```dart
///Uri.https(AppApis().baseUrl, AppApis().epSearch, {
/// AppApis().paramApiKey: AppApis().apiKey,
/// AppApis().paramLanguage: AppApis().defaultLanguage,
/// AppApis().paramSearch: [keyword],
/// AppApis().paramPage: [page],
///});
///```
class AppApis {
  factory AppApis() => _singleton;

  static final AppApis _singleton = AppApis._internal();

  AppApis._internal();

  late final String _cachedApiKey;

  Future<void> loadApiKey({String? apiKey}) async {
    _cachedApiKey = apiKey ?? await rootBundle.loadString(
      'assets/apikey.txt',
      cache: false,
    );
  }

  String get apiKey => _cachedApiKey;

  final String baseUrl = 'api.themoviedb.org';

  final String epDiscover = '/3/discover/movie';
  final String epMovieDetail = '/3/movie/';
  final String epSearch = '/3/search/movie';

  final String baseImageUrl = 'https://image.tmdb.org';
  final String epThumbImage = '/t/p/w500';
  final String epOriginalImage = '/t/p/original';

  final String paramApiKey = 'api_key';
  final String paramLanguage = 'language';
  final String defaultLanguage = 'en-US';

  ///YYYY-MM-DD
  final String paramNowPlaying = 'release_date.lte';

  ///YYYY-MM-DD
  final String paramUpcoming = 'primary_release_date.gte';

  ///YYYY
  final String paramYear = 'year';
  final String paramPage = 'page';
  final String paramSearch = 'query';
}
