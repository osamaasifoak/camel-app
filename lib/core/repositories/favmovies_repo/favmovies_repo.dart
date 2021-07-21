import 'dart:async';

import 'package:camelmovies/core/services/localdb_service/base_localdb_service.dart';
import 'package:sqflite/sqflite.dart';

import '/core/models/movie/base_movie.dart';

import 'base_favmovies_repo.dart';

class FavMoviesRepository implements BaseFavMoviesRepository {

  final BaseLocalDbService _localDbService;

  final StreamController<int> _favCountController;

  FavMoviesRepository({
    required BaseLocalDbService localDbService,
    StreamController<int>? favCountStream
  }) : _localDbService = localDbService,
        _favCountController = favCountStream ?? StreamController();

  @override
  StreamController<int> get favCountController => _favCountController;

  @override
  Future<int> getFavCount() async {
    final favCount = await _localDbService.select(
      table: _localDbService.favTable,
      columns: ['COUNT(*)'],
    );
    return Sqflite.firstIntValue(favCount) ?? 0;
  }

  @override
  Future<void> close() async {
    await _favCountController.sink.close();
  }

  Future<List<BaseMovie>> getFavList() async {
    final List<Map<String, Object?>> favList = await _localDbService.select(
      table: _localDbService.favTable,
    );

    return List<BaseMovie>.from(favList.map((fav) => BaseMovie.fromMap(fav)));
  }

  Future<void> insertFav(num? id) async {
    if(id == null) return;
    
    final movie = {
      'id': id,
    };

    await _localDbService.insert(
      table: _localDbService.favTable,
      values: movie,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final favCount = await getFavCount();
    _favCountController.add(favCount);
  }

  Future<void> deleteFav(num? id) async {
    if (id == null) return;

    await _localDbService.delete(
      table: _localDbService.favTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    final favCount = await getFavCount();
    _favCountController.add(favCount);
  }

  Future<bool> isFav(num? id) async {
    if (id == null) return false;

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
