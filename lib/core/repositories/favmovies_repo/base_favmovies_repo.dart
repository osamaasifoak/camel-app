
import '/core/models/movie/base_movie.dart';

abstract class BaseFavMoviesRepository{
  Future<int> getFavCount();
  Future<List<BaseMovie>> getFavList();
  Future<void> insertFav(num? id);
  Future<void> deleteFav(num? id);
  Future<bool> isFav(num? id);
}