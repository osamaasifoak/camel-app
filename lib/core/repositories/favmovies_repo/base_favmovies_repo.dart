import 'dart:async';

import 'package:rxdart/rxdart.dart' show BehaviorSubject;

import '/core/models/movie/base_movie.dart';

abstract class BaseFavMoviesRepository {
  BehaviorSubject<int> get favCountController;
  Future<int> getFavCount();
  /// [page] starts from 0
  /// 
  /// [perPage] max items to be returned
  Future<List<BaseMovie>> getFavList({
    int page = 0,
    int perPage = 10,
  });
  Future<void> insertFav(int id);
  Future<void> deleteFav(int id);
  Future<bool> isFav(int id);
  Future<void> close();
}
