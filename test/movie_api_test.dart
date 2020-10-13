import 'package:flutter_test/flutter_test.dart';
import 'package:popular_movies/network/remote.dart';

void main() {
  group("Movie API", () {
    test("the api request gives back a response", () async {
      final response = await Remote.fetchPopularMovies();
      expect(response, isNotNull);

      print('page: ${response.page}');
      print('total_results: ${response.total_results}');
      print('total_pages: ${response.total_pages}');
      print('results: ${response.results}');
    });

    test("the response has results more than 0", () async {
      final response = await Remote.fetchPopularMovies();
      final movies = response.results;
      expect(movies.length, greaterThan(0));
    });

    test("the results are structured as the Movie data class", () async {
      final response = await Remote.fetchPopularMovies();
      final movies = response.results;
      bool thereIsNullValue = false;

      movies.forEach((movie) {
        if (movie.popularity == null) thereIsNullValue = true;
        if (movie.vote_count == null) thereIsNullValue = true;
        if (movie.isVideo == null) thereIsNullValue = true;
        if (movie.poster_path == null) thereIsNullValue = true;
        if (movie.isAdult == null) thereIsNullValue = true;
        if (movie.backdrop_path == null) thereIsNullValue = true;
        if (movie.original_language == null) thereIsNullValue = true;
        if (movie.original_title == null) thereIsNullValue = true;
        if (movie.genres == null) thereIsNullValue = true;
        if (movie.title == null) thereIsNullValue = true;
        if (movie.vote_average == null) thereIsNullValue = true;
        if (movie.overview == null) thereIsNullValue = true;
        if (movie.release_date == null) thereIsNullValue = true;
      });

      expect(thereIsNullValue, false);

      movies.forEach((movie) {movie.printMovie();});
    });

    test("movie request gives back a movie", () async {
      final movie = await Remote.fetchMovie(100);
      expect(movie, isNotNull);

      movie.printMovie();
    });

    test("movie has genres field as string", () async {
      final movie = await Remote.fetchMovie(100);
      expect(movie.genres, isNotNull);

      print(movie.genres);
    });

  });
}
