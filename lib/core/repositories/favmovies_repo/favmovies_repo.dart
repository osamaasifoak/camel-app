import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

import '/core/models/fav_entertainment_show/fav_entertainment_show.dart';
import '/core/services/localdb_service/base_localdb_service.dart';
import 'base_favmovies_repo.dart';

class FavMoviesRepository implements BaseFavMoviesRepository {

  static const String favMoviesTableName = 'fav_movie';
  static const String createFavMovieTableQuery = 
    'CREATE TABLE $favMoviesTableName '
    '(id INTEGER PRIMARY KEY, '
    'added_on INTEGER)';

  FavMoviesRepository({
    BaseLocalDbService? localDbService,
    BehaviorSubject<int>? favCountController,
  })  : _localDbService = localDbService ?? GetIt.I<BaseLocalDbService>(),
        favCountController = favCountController ?? BehaviorSubject<int>();

  final BaseLocalDbService _localDbService;

  @override
  final BehaviorSubject<int> favCountController;

  @override
  Future<int> getFavCount() async {
    final favCount = await _localDbService.select(
      table: favMoviesTableName,
      columns: ['COUNT(*)'],
    );
    return Sqflite.firstIntValue(favCount) ?? 0;
  }

  @override
  Future<void> close() => favCountController.close();

  @override
  Future<List<int>> getFavList({
    int page = 0,
    int perPage = 10,
  }) async {
    assert(page >= 0);
    final List<Map<String, Object?>> favList = await _localDbService.select(
      table: favMoviesTableName,
      offset: page * perPage,
      limit: perPage,
      columns: ['id'],
      orderBy: 'added_on DESC',
    );

    return favList.map<int>((fav) => fav['id']! as int).toList();
  }

  @override
  Future<void> insertFav(FavEShow favEShow) async {

    await _localDbService.insert(
      table: favMoviesTableName,
      values: favEShow.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    refreshFavMoviesCount();
  }

  @override
  Future<void> deleteFav(int id) async {

    await _localDbService.delete(
      table: favMoviesTableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    refreshFavMoviesCount();
  }

  @override
  Future<bool> isFav(int id) async {

    final List<Map<String, Object?>> findFav = await _localDbService.select(
      table: favMoviesTableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (findFav.isEmpty) return false;
    return true;
  }

  @override
  void refreshFavMoviesCount() {
    getFavCount().then(favCountController.add);
  }
}
