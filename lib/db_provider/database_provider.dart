//import 'dart:io';
//
//import 'package:books_bay/models/book.dart';
//import 'package:books_bay/models/comment.dart';
import 'package:books_bay/models/db_models/db_models.dart';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Future _create(Database db, int version) async {
  await db.execute("""
            CREATE TABLE downloads (
              id TEXT PRIMARY KEY,
              image_name TEXT,
              title TEXT,
              cover_image_name TEXT,
              author TEXT,
              book_name TEXT,
              is_downloaded TEXT
            )""");
}

class DatabaseProvider {
  Database _db;

  DatabaseProvider._();

  static final _instance = DatabaseProvider._();

  factory DatabaseProvider() {
    return _instance;
  }

  Future<Database> get database async {
    if (_db != null) {
      return _db;
    }
    _db = await init();
    return _db;
  }

  Future<Database> init() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "books_bay.db");
    print('database created');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _create,
    );
  }

  Future insert(Download download) async {
    final db = await database;
    await db.insert(
      'downloads',
      download.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<Download> findById(String id) async {
    final db = await database;
    final response =
        await db.query('downloads', where: 'id = ?', whereArgs: [id], limit: 1);
    return Download.fromMap(response[0]);
  }

  Future update(Download download) async {
    final db = await database;
    await db.update(
      'downloads',
      {
        'is_downloaded': 'true',
      },
      where: 'id = ?',
      whereArgs: [download.id],
    );
  }

  Future remove(Download download) async {
    final db = await database;
    await db.delete('downloads', where: 'id = ?', whereArgs: [download.id]);
  }

  Future insertAll(List<Download> downloads) async {
    final db = await database;
    downloads.forEach((download) async {
      await db.insert(
        'downloads',
        download.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    });
  }

  Future<List<Download>> retrieveAll() async {
    final db = await database;
    final List<Map<String, dynamic>> downloads = await db.query('downloads');
    return downloads.map((download) => Download.fromMap(download)).toList();
  }
}
