import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;
import 'package:sqflite/sqflite.dart' show Sqflite, ConflictAlgorithm;

import '/core/models/fav_entertainment_show/fav_entertainment_show.dart';
import '/core/repositories/fav_tv_shows_repo/base_fav_tv_shows_repo.dart';
import '/core/services/localdb_service/base_localdb_service.dart';

class FavTVShowsRepository implements BaseFavTVShowsRepository {

  static const String favTVShowsTableName = 'fav_tv';

  static const String createFavTVShowsTableQuery = 
    'CREATE TABLE $favTVShowsTableName '
    '(id INTEGER PRIMARY KEY, '
    'added_on INTEGER)';

  FavTVShowsRepository({
    BaseLocalDbService? localDbService,
    BehaviorSubject<int>? favTVCountController,
  })  : _localDbService = localDbService ?? GetIt.I<BaseLocalDbService>(),
        favTVCountController = favTVCountController ?? BehaviorSubject<int>();

  final BaseLocalDbService _localDbService;

  @override
  final BehaviorSubject<int> favTVCountController;
  @override
  Future<void> close() => favTVCountController.close();

  @override
  Future<void> deleteFavTV(int id) async {
    await _localDbService.delete(
      table: favTVShowsTableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    refreshFavTVShowsCount();
  }

  @override
  Future<int> getFavTVCount() async {
    final favTVCount = await _localDbService.select(
      table: favTVShowsTableName,
      columns: ['COUNT(*)'],
    );
    return Sqflite.firstIntValue(favTVCount) ?? 0;
  }

  @override
  Future<List<int>> getFavTVList({
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
  Future<void> insertFavTV(FavEShow favEShow) async {
    await _localDbService.insert(
      table: favTVShowsTableName,
      values: favEShow.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    refreshFavTVShowsCount();
  }

  @override
  Future<bool> isFavTV(int id) async {
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
  void refreshFavTVShowsCount() {
    getFavTVCount().then(favTVCountController.add);
  }
}
