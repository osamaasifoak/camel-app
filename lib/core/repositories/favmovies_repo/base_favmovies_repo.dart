import 'dart:async';

import 'package:rxdart/rxdart.dart' show BehaviorSubject;

import '/core/models/fav_entertainment_show/fav_entertainment_show.dart';

abstract class BaseFavMoviesRepository {
  BehaviorSubject<int> get favCountController;
  void refreshFavMoviesCount();
  Future<int> getFavCount();
  /// [page] starts from 0
  /// 
  /// [perPage] max items to be returned
  Future<List<int>> getFavList({
    int page = 0,
    int perPage = 10,
  });
  Future<void> insertFav(FavEShow favEShow);
  Future<void> deleteFav(int id);
  Future<bool> isFav(int id);
  Future<void> close();
}
