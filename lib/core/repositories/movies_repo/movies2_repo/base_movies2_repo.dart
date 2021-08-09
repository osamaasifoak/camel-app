import '../base_movies_repo.dart';
import '/core/models/movie/movie.dart';
import '/core/models/movie/movie_review.dart';

abstract class BaseMovies2Repository extends BaseMoviesRepository {
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<MovieReview>> getMovieReviews({
    required int movieId,
    int page = 1,
  });
}
