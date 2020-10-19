
import 'package:popular_movies/models/data/movie.dart';

import 'movie_dao.dart';

class MovieDiskDataSource {
  final MovieDao _movieDao;

  MovieDiskDataSource(this._movieDao);


  Future<void> insertDbMovie(Movie movie) async {
    _movieDao.insertDbMovie(movie);
  }


  Future<List<Movie>> getDbMovies() async {
    return _movieDao.getDbMovies();
  }


  Future<void> updateDbMovie(Movie movie) async {
    _movieDao.updateDbMovie(movie);
  }


  Future<void> deleteDbMovie(num id) async {
    _movieDao.deleteDbMovie(id);
  }
}