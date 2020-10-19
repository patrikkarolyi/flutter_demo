import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:popular_movies/models/db/movie_disk_data_source.dart';
import 'package:popular_movies/models/movie_model.dart';

import 'data/movie.dart';

class FavesModel extends ChangeNotifier {
  final MovieModel _movieModel;
  final List<Movie> _movies;

  FavesModel(this._movieModel, FavesModel previous)
      : assert(_movieModel != null),
        _movies = previous?._movies ?? [];

  void getFavoriteMoviesFromDb() async {
    final oldElements = await _diskDataSource.getDbMovies();
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
    _diskDataSource.insertDbMovie(movie);
  }

  void remove(num id) {
    final Movie movie = _movies.firstWhere((e) => e.id == id);
    _movies.remove(movie);
    notifyListeners();
    _diskDataSource.deleteDbMovie(id);
  }

  int get length => _movies.length;
}
