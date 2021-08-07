import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

import '/core/models/movie/base_movie.dart';
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
      table: _localDbService.favTable,
      columns: ['COUNT(*)'],
    );
    return Sqflite.firstIntValue(favCount) ?? 0;
  }

  @override
  Future<void> close() => favCountController.close();

  @override
  Future<List<BaseMovie>> getFavList({
    int page = 0,
    int perPage = 10,
  }) async {
    assert(page >= 0);
    final List<Map<String, Object?>> favList = await _localDbService.select(
      table: _localDbService.favTable,
      offset: page * perPage,
      limit: perPage,
    );

    return List<BaseMovie>.from(favList.map((fav) => BaseMovie.fromMap(fav)));
  }

  @override
  Future<void> insertFav(int id) async {

    final movie = {
      'id': id,
    };

    await _localDbService.insert(
      table: _localDbService.favTable,
      values: movie,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    getFavCount().then(favCountController.add);
  }

  @override
  Future<void> deleteFav(int id) async {

    await _localDbService.delete(
      table: _localDbService.favTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    getFavCount().then(favCountController.add);
  }

  @override
  Future<bool> isFav(int id) async {

    final List<Map<String, Object?>> findFav = await _localDbService.select(
      table: _localDbService.favTable,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (findFav.isEmpty) return false;
    return true;
  }
}
