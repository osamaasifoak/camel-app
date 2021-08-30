
import 'package:sqflite/sqflite.dart';

abstract class BaseLocalDbService {

  Future<void> clearDb();
  Future<void> closeDb();

  /// this is used if multiple queries are needed,
  ///
  /// note: Do Not call `batch.commit()`, this method will do it.
  Future<List<Object?>> batch(
    void Function(Batch batch) batchesFn, {
    bool noResult = true,
    bool? exclusive,
    bool? continueOnError,
    Transaction? txn,
  });

  /// For smaller multi queries, [batch] might be a better suit.
  ///
  /// Example:
  /// ```dart
  /// await localDbService.transaction((txn) async {
  ///   final List<Map<String, dynamic>> movieList = await localDbService.select(
  ///     tablename: localDbService.dbMovie,
  ///     txn: txn,
  ///   );
  /// });
  /// ```
  Future<T> transaction<T>(
    Future<T> Function(Transaction txn) action, {
    bool? exclusive,
  });

  Future<int> insert({
    required String table,
    required Map<String, Object?> values,
    ConflictAlgorithm? conflictAlgorithm,
    Transaction? txn,
  });

  Future<int> update({
    required String table,
    required Map<String, Object?> values,
    String? where,
    List<Object?>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
    Transaction? txn,
  });

  Future<int> delete({
    required String table,
    String? where,
    List<Object?>? whereArgs,
    Transaction? txn,
  });

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
  });
}