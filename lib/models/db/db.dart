import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  Future<Database> _database;

  Future<Database> getDb() => _database;

  Future<void> initDb() async {
    WidgetsFlutterBinding.ensureInitialized();

    _database = openDatabase(
      join(await getDatabasesPath(), 'movie_database.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE movies("
          "id INTEGER PRIMARY KEY,"
          " poster_path TEXT,"
          " popularity REAL,"
          " vote_count INTEGER,"
          " is_video INTEGER,"
          " is_adult INTEGER,"
          " backdrop_path TEXT,"
          " original_language TEXT,"
          " original_title TEXT,"
          " title TEXT,"
          " vote_average REAL,"
          " overview TEXT,"
          " release_date TEXT,"
          " runtime Text)",
        );
      },
    );
  }
}
