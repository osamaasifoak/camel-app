import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

import '/core/models/fav_entertainment_show/fav_entertainment_show.dart';
import '/core/services/localdb_service/base_localdb_service.dart';
import 'base_favmovies_repo.dart';

class FavMoviesRepository implements BaseFavMoviesRepository {
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
      table: _localDbService.movieFavsTable,
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
      table: _localDbService.movieFavsTable,
      offset: page * perPage,
      limit: perPage,
      columns: ['id'],
      orderBy: 'added_on DESC',
    );

    return favList.map<int>((fav) => fav['id'] as int).toList();
  }

  @override
  Future<void> insertFav(FavEShow favEShow) async {

    await _localDbService.insert(
      table: _localDbService.movieFavsTable,
      values: favEShow.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    refreshFavMoviesCount();
  }

  @override
  Future<void> deleteFav(int id) async {

    await _localDbService.delete(
      table: _localDbService.movieFavsTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    refreshFavMoviesCount();
  }

  @override
  Future<bool> isFav(int id) async {

    final List<Map<String, Object?>> findFav = await _localDbService.select(
      table: _localDbService.movieFavsTable,
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
