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

  Future<void> loadApiKey() async {
    _cachedApiKey = await rootBundle.loadString('assets/apikey.txt', cache: false);
  }

  String get apiKey => _cachedApiKey;

  String get baseUrl => 'api.themoviedb.org';

  String get epDiscover => '/3/discover/movie';
  String get epMovieDetail => '/3/movie/';
  String get epSearch => '/3/search/movie';

  String get baseImageUrl => 'https://image.tmdb.org';
  String get epThumbImage => '/t/p/w500';
  String get epOriginalImage => '/t/p/original';

  String get paramApiKey => 'api_key';
  String get paramLanguage => 'language';
  String get defaultLanguage => 'en-US';

  ///YYYY-MM-DD
  String get paramNowPlaying => 'release_date.lte';

  ///YYYY-MM-DD
  String get paramUpcoming => 'primary_release_date.gte';

  ///YYYY
  String get paramYear => 'year';
  String get paramPage => 'page';
  String get paramSearch => 'query';
}
