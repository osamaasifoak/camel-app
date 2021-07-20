import 'package:camelmovies/core/services/localdb_service/base_localdb_service.dart';
import 'package:sqflite/sqflite.dart';

import '/core/models/movie/base_movie.dart';

import 'base_favmovies_repo.dart';

class FavMoviesRepository implements BaseFavMoviesRepository {
  final BaseLocalDbService _localDbService;

  const FavMoviesRepository({
    required BaseLocalDbService localDbService,
  }) : _localDbService = localDbService;

  Future<int> getFavCount() async {
    final favCount = await _localDbService.select(
      table: _localDbService.favTable,
      columns: ['COUNT(*)'],
    );
    return Sqflite.firstIntValue(favCount) ?? 0;
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
  }

  Future<void> deleteFav(num? id) async {
    if (id == null) return;

    await _localDbService.delete(
      table: _localDbService.favTable,
      where: 'id = ?',
      whereArgs: [id],
    );
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
