import '/core/models/movie/base_movie.dart';
import '/core/models/movie/movie_detail.dart';
import '/core/models/movie/movie.dart';

abstract class BaseMoviesRepository {
  Future<List<Movie>> getMovieListById(List<BaseMovie> movieIds);
  Future<MovieDetail> getMovieDetail(num? id);
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> searchMovie(String keyword, {int page = 1});
}