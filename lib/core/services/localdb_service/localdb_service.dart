import 'dart:async' show Completer;
import 'dart:developer' as dev show log;

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path show join;

import '/core/services/localdb_service/base_localdb_service.dart';

const String _dbFileName = 'user_prefs.db';

class LocalDbService implements BaseLocalDbService {
  @override
  final String movieFavsTable = 'fav_movie';

  @override
  final String tvFavsTable = 'fav_tv';

  late final String _createFavMovieTable = 
    'CREATE TABLE $movieFavsTable '
    '(id INTEGER PRIMARY KEY, '
    'added_on INTEGER)';

  late final String _createFavTVTable = 
    'CREATE TABLE $tvFavsTable '
    '(id INTEGER PRIMARY KEY, '
    'added_on INTEGER)';

  late final List<String> _createAllTables = [
    _createFavMovieTable,
    _createFavTVTable,
  ];

  late final List<String> _tablesToBeCleared = [
    movieFavsTable,
    tvFavsTable,
  ];

  final _database = Completer<Database>();

  LocalDbService({Database? database}) {
    _initDb(database: database);
  }

  Future<void> _initDb({Database? database}) async {
    if (database != null) {
      _database.complete(database);
    }
    try {
      final dbPath = path.join(
        await getDatabasesPath(),
        _dbFileName,
      );
      final openedDb = await openDatabase(
        dbPath,
        onCreate: _createTables,
        version: 1,
      );
      _database.complete(openedDb);
      if (kDebugMode) {
        dev.log('Database initialized!');
      }
    } catch (e, st) {
      if (kDebugMode) {
        dev.log(
          e.toString(),
          stackTrace: st,
        );
      }
    }
  }

  Future<void> _createTables(Database db, int version) async {
    final batch = db.batch();
    _createAllTables.forEach(batch.execute);
    await batch.commit(noResult: true);
  }

  @override
  Future<List<Object?>> batch(
    void Function(Batch batch) batchesFn, {
    bool noResult = true,
    bool? exclusive,
    bool? continueOnError,
    Transaction? txn,
  }) async {
    final batch = (txn ?? await _database.future).batch();

    batchesFn(batch);

    if (kDebugMode) {
      dev.log(
        '----------\n'
        '[LocalDbService.batch] called!\n'
        'batches: ${batch.toString()}\n'
        '----------\n',
      );
    }

    return batch.commit(
      exclusive: exclusive,
      noResult: noResult,
      continueOnError: continueOnError,
    );
  }

  @override
  Future<void> clearDb() async {
    final batch = (await _database.future).batch();
    _tablesToBeCleared.forEach(batch.delete);
    await batch.commit(noResult: true);
  }

  @override
  Future<void> closeDb() => _database.future.then((db) => db.close());

  @override
  Future<int> delete({
    required String table,
    String? where,
    List<Object?>? whereArgs,
    Transaction? txn,
  }) async {
    return (txn ?? await _database.future).delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  @override
  Future<int> insert({
    required String table,
    required Map<String, Object?> values,
    ConflictAlgorithm? conflictAlgorithm,
    Transaction? txn,
  }) async {
    return (txn ?? await _database.future).insert(
      table,
      values,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  @override
  Future<List<Map<String, Object?>>> select({
    required String table,
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
    Transaction? txn,
  }) async {
    return (txn ?? await _database.future).query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<int> update({
    required String table,
    required Map<String, Object?> values,
    String? where,
    List<Object?>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
    Transaction? txn,
  }) async {
    return (txn ?? await _database.future).update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  @override
  Future<T> transaction<T>(
    Future<T> Function(Transaction txn) action, {
    bool? exclusive,
  }) async {
    return (await _database.future).transaction(
      action,
      exclusive: exclusive,
    );
  }
}
