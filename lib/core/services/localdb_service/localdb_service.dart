
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path show join;

import 'package:camelmovies/core/models/movie/base_movie.dart';

class LocalDbService {
  late final Future<Database> _database;
  static const String _tableName = 'fav';
  static const String _createTable = 'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY)';
  static const String _getCount = 'SELECT COUNT(*) FROM $_tableName';
  
  LocalDbService(){
    init();
  }

  init() async {
    try{
      _database = openDatabase(
        path.join(await getDatabasesPath(), "userpref.db"),
        onCreate: (db, ver) async{
          return await db.execute(_createTable);
        },
        version: 1,
      );
    }catch(e, st){
      print(st);
    }
  }

  Future<int?> getFavCount() async{
    int? count = 0;
    try{
      final Database db = await _database;
      var rawCount = await db.rawQuery(_getCount);
      count = Sqflite.firstIntValue(rawCount);
    }catch(e, st){
      print(e);
      print(st);
    }
    return count;
  }

  Future<List<BaseMovie>> getFavList() async {
    try{

      final Database db = await _database;
      final List<Map<String,dynamic>> list = await db.query(_tableName);
      
      return List.generate(list.length, (i) => BaseMovie.fromMap(list[i]));
      
    }catch(e, st){
      print(st);
    }
    return [];
  }


  Future<bool> insertFav(num? id) async {
    bool res = true;
    try{
      final Database db = await _database;
      var movie = {
        'id': id,
      };
      
      await db.insert(
        _tableName,
        movie,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }catch(e, st){
      print(st);
      res = false;
    }
    return res;
  }

  Future<bool> deleteFav(num? id) async {
    bool res = true;
    try{
      final Database db = await _database;
      await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    }catch(e, st){
      print(st);
      res = false;
    }
    return res;
  }
  
  Future<bool> isFav(num? id) async {
    bool isfav = false;
    try{
      final Database db = await _database;
      final List<Map<String,dynamic>> list = await db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      //print(list);
      if(list.length > 0) isfav = true;
    }catch(e, st){
      print(st);
    }
    return isfav;
  }

}