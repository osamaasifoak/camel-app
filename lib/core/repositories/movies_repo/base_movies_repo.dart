import '/core/models/movie/movie.dart';
import '/core/models/movie/movie_detail.dart';

abstract class BaseMoviesRepository {
  Future<List<Movie>> getMovieListById(List<int> movieIds);
  Future<MovieDetail> getMovieDetail(int id);
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> searchMovie(String keyword, {int page = 1});
}