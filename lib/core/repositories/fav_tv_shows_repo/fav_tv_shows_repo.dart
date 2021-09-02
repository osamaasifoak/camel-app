import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;
import 'package:sqflite/sqflite.dart' show Sqflite, ConflictAlgorithm;

import '../base_fav_eshows_repo.dart';
import '/core/models/fav_entertainment_show/fav_entertainment_show.dart';
import '/core/services/localdb_service/base_localdb_service.dart';

class FavTVShowsRepository implements BaseFavEShowsRepository {
  static const String favTVShowsTableName = 'fav_tv';
  static const String createFavTVShowsTableQuery = 
      'CREATE TABLE $favTVShowsTableName '
      '(id INTEGER PRIMARY KEY, '
      'added_on INTEGER)';

  FavTVShowsRepository({
    BaseLocalDbService? localDbService,
    BehaviorSubject<int>? favCountController,
  })  : _localDbService = localDbService ?? GetIt.I<BaseLocalDbService>(),
        favCountController = favCountController ?? BehaviorSubject<int>() {
    refreshFavCount();
  }

  final BaseLocalDbService _localDbService;

  @override
  final BehaviorSubject<int> favCountController;
  @override
  Future<void> close() => favCountController.close();

  @override
  Future<void> deleteFav(int id) async {
    await _localDbService.delete(
      table: favTVShowsTableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    refreshFavCount();
  }

  @override
  Future<int> getFavCount() async {
    final favTVCount = await _localDbService.select(
      table: favTVShowsTableName,
      columns: ['COUNT(*)'],
    );
    return Sqflite.firstIntValue(favTVCount) ?? 0;
  }

  @override
  Future<List<int>> getFavList({
    int page = 0,
    int perPage = 10,
  }) async {
    assert(page >= 0);
    final List<Map<String, Object?>> favList = await _localDbService.select(
      table: favTVShowsTableName,
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
      table: favTVShowsTableName,
      values: favEShow.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    refreshFavCount();
  }

  @override
  Future<bool> isFav(int id) async {
    final List<Map<String, Object?>> findFav = await _localDbService.select(
      table: favTVShowsTableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (findFav.isEmpty) return false;
    return true;
  }

  @override
  void refreshFavCount() {
    getFavCount().then(favCountController.add);
  }
}
