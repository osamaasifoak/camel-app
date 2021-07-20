import 'dart:async' show FutureOr;
import 'dart:developer' as dev show log;

import 'package:camelmovies/core/services/localdb_service/base_localdb_service.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path show join;

const String _dbFileName = 'userpref.db';

class LocalDbService implements BaseLocalDbService {

  final String _favTable = 'fav';
  @override
  String get favTable => _favTable;

  late final String _createFavTable = 'CREATE TABLE $_favTable(id INTEGER PRIMARY KEY)';

  late final List<String> _createAllTables = [
    _createFavTable,
  ];

  late final List<String> _tablesToBeCleared = [
    _favTable,
  ];

  late final Database _database;

  @override
  FutureOr<bool> initDb([Database? database]) async {
    if (database != null) {
      _database = database;
      return true;
    }
    try {
      final dbPath = path.join(await getDatabasesPath(), _dbFileName);
      _database = await openDatabase(
        dbPath,
        onCreate: _createTables,
        version: 1,
      );
      if (kDebugMode) {
        dev.log('Database initialized!');
      }
      return true;
    } catch (e, st) {
      if (kDebugMode) {
        dev.log(
          e.toString(),
          stackTrace: st,
        );
      }
    }
    return false;
  }

  void _createTables(Database db, int version) async {
    final batch = db.batch();
    for (final table in _createAllTables) {
      batch.execute(table);
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<Object?>> batch(
    void Function(Batch batch) batchesFn, {
    bool noResult = true,
    bool? exclusive,
    bool? continueOnError,
    Transaction? txn,
  }) {
    final batch = (txn ?? _database).batch();

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
    final batch = _database.batch();
    for (String tableName in _tablesToBeCleared) {
      batch.delete(tableName);
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<void> closeDb() => _database.close();

  @override
  Future<int> delete({
    required String table,
    String? where,
    List<Object?>? whereArgs,
    Transaction? txn,
  }) {
    return (txn ?? _database).delete(
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
  }) {
    return (txn ?? _database).insert(
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
  }) {
    return (txn ?? _database).query(
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
  }) {
    return (txn ?? _database).update(
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
  }) {
    return _database.transaction(
      action,
      exclusive: exclusive,
    );
  }
}
