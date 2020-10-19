import 'package:popular_movies/models/data/movie.dart';
import 'package:popular_movies/models/utils/Utils.dart';
import 'package:sqflite/sqflite.dart';

import 'db.dart';

Future<void> insertDbMovie(Movie movie) async {
  final Database db = await  Db.getDb();
  await db.insert(
    'movies',
    movie.toMap(),
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
}


Future<List<Movie>> getDbMovies() async {
  final Database db = await Db.getDb();

  // Query the table for all The Movies.
  final List<Map<String, dynamic>> maps = await db.query('movies');

  // Convert the List<Map<String, dynamic> into a List<Movie>.
  return List.generate(maps.length, (i) {
    return Movie(
      id: maps[i]['id'],
      popularity: maps[i]['popularity'],
      vote_count: maps[i]['vote_count'],
      isVideo: intToBool(maps[i]['is_video']),
      poster_path: maps[i]['poster_path'],
      isAdult: intToBool(maps[i]['is_adult']),
      backdrop_path: maps[i]['backdrop_path'],
      original_language: maps[i]['original_language'],
      original_title: maps[i]['original_title'],
      title: maps[i]['title'],
      vote_average: maps[i]['vote_average'],
      overview: maps[i]['overview'],
      release_date: maps[i]['release_date'],
      runtime: maps[i]['runtime'],
      genres: null,
    );
  });
}


Future<void> updateDbMovie(Movie movie) async {
  final db = await  Db.getDb();
  await db.update(
    'movies',
    movie.toMap(),
    // Ensure that the Movie has a matching id.
    where: "id = ?",
    //prevent SQL injection.
    whereArgs: [movie.id],
  );
}


Future<void> deleteDbMovie(num id) async {
  final db = await  Db.getDb();
  await db.delete(
    'movies',
    // Use a `where` clause to delete a specific movie.
    where: "id = ?",
    //prevent SQL injection.
    whereArgs: [id],
  );
}