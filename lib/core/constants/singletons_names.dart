
/// singletons instance names
class SIName {
  static const _SingletonRepositories repo = _SingletonRepositories();
}

/// singleton repository instances names
class _SingletonRepositories {
  const _SingletonRepositories();
  String get movies => 'movies';
  String get favMovies => 'fav-movies';
  String get tvShows => 'tv-shows';
  String get favTVShows => 'fav-tvshows';
}