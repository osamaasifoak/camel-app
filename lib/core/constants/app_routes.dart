class AppRoutes {
  static const String home = '/';
  static const String splash = '/1';

  static const String movieDetail = '/movie';
  static const String nowPlayingMovieList = '/movies/now_playing';
  static const String popularMovieList = '/movies/popular';
  static const String upcomingMovieList = '/movies/upcoming';
  static const String favMovies = '/fav/movies';

  static const String tvShowDetail = '/tv';
  static const String popularTVShowList = '/tv_shows/popular';
  static const String onTheAirTVShowList = '/tv_shows/on_the_air';
  static const String favTVShows = '/fav/tv_shows';

  static const String searchShows = '/search';

  static String getMovieDetail(int movieId) {
    return Uri(
      path: movieDetail,
      queryParameters: <String, String>{
        'id': movieId.toString(),
      },
    ).toString();
  }

  static String getTVShowDetail(int tvShowId) {
    return Uri(
      path: tvShowDetail,
      queryParameters: <String, String>{
        'id': tvShowId.toString(),
      },
    ).toString();
  }
}
