import 'package:flutter/material.dart';
import 'package:popular_movies/models/MovieModel.dart';

import 'data/Movie.dart';
import 'db/MovieDao.dart';

class FavesModel extends ChangeNotifier {
  final MovieModel _movieModel;
  final List<Movie> _movies;

  FavesModel(this._movieModel, FavesModel previous)
      : assert(_movieModel != null),
        _movies = previous?._movies ?? [];

  void getFavoriteMoviesFromDb() async {
    final oldElements = await getDbMovies();
    _movies.addAll(oldElements);
    notifyListeners();
  }

  List<Movie> getMovies() {
    return _movies;
  }

  void add(num id) {
    final Movie movie = _movieModel.getById(id);
    _movies.add(movie);
    notifyListeners();
    insertDbMovie(movie);
  }

  void remove(num id) {
    final Movie movie = _movieModel.getById(id);
    _movies.remove(movie);
    notifyListeners();
    deleteDbMovie(id);
  }

  int get length => _movies.length;
}
