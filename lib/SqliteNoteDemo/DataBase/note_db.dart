import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class NoteDatabase{
  static Database? _database;

  static const dbname = "db_note.db";
  static const table = "table_note";
  static const nid = "id";
  static const title = "title";
  static const description = "description";

  Future<Database> get database async{
    if(_database!= null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  initDatabase() async{
    Directory directory  = await getApplicationDocumentsDirectory();
    var path = join(directory.path,dbname);
    return await openDatabase(path,onCreate: _onCreate,version: 1);

}


  Future<FutureOr<void>> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table(
          $nid INTEGER PRIMARY KEY,
          $title TEXT NOT NULL,
          $description TEXT NOT NULL
        )
    ''');
  }
  insertDb(Map<String, dynamic> map) async {
    Database db = await database;
    return db.insert(table, map);
  }

  selectDb() async {
    Database db = await database;
    return db.query(table);
  }
  updateDb(Map<String, dynamic> map, int id) async {
    Database db = await database;
    return db.update(table, map, where: '$nid=?', whereArgs: [id]);
  }

  deleteDb(int id) async {
    Database db = await database;
    return db.delete(table, where: '$nid=?', whereArgs: [id]);
  }
}