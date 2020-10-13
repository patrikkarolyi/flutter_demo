import 'package:flutter/widgets.dart';
import 'package:popular_movies/network/remote.dart';

import 'data/Movie.dart';

class MovieModel extends ChangeNotifier {
  List<Movie> _movies = List<Movie>();

  void setMovies(List<Movie> newMovies) {
    _movies = newMovies;
  }

  List<Movie> getMovieList() {
    return _movies;
  }

  int get length => _movies.length;

  Movie getById(id) => _movies.firstWhere((element) => element.id == id);

  Future fetchTopRatedMovies() async {
    await Remote.fetchTopRatedMovies().then((value) => _movies = value.results);
    notifyListeners();
    //TODO save to db
  }

  Future fetchPopularMovies() async {
    await Remote.fetchPopularMovies().then((value) => _movies = value.results);
    notifyListeners();
    //TODO remove from db
  }
}
