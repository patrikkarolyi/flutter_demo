import 'package:flutter/material.dart';
import 'package:popular_movies/models/MovieModel.dart';

import 'data/Movie.dart';

class FavesModel extends ChangeNotifier {
  final MovieModel _movies;
  final List<num> _movieIds;

  FavesModel(this._movies, FavesModel previous)
      : assert(_movies != null),
        _movieIds = previous?._movieIds ?? [];

  List<Movie> get movies => _movieIds.map((id) => _movies.getById(id)).toList();

  Movie getByPosition(int position) => movies[position];

  List<num> getMovieIds(){
    return _movieIds;
  }

  void add(num id){
    _movieIds.add(id);
    notifyListeners();
  }

  void remove (num id){
    _movieIds.remove(id);
    notifyListeners();
  }

  int get length => _movieIds.length;
}