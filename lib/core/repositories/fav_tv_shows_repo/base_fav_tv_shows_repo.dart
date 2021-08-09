import 'package:rxdart/rxdart.dart' show BehaviorSubject;
import '/core/models/fav_entertainment_show/fav_entertainment_show.dart';

abstract class BaseFavTVShowsRepository {
  BehaviorSubject<int> get favTVCountController;
  void refreshFavTVShowsCount();
  Future<int> getFavTVCount();
  /// [page] starts from 0
  ///
  /// [perPage] max items to be returned
  Future<List<int>> getFavTVList({
    int page = 0,
    int perPage = 10,
  });
  Future<void> insertFavTV(FavEShow favEShow);
  Future<void> deleteFavTV(int id);
  Future<bool> isFavTV(int id);
  Future<void> close();
}
