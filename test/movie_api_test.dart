import 'package:flutter_test/flutter_test.dart';
import 'package:popular_movies/network/remote.dart';

void main() {
  group("Movie API", () {
    test("the api request gives back a response", () async {
      final response = await Remote.fetchMovies();
      expect(response, isNotNull);

      print('page: ${response.page}');
      print('total_results: ${response.total_results}');
      print('total_pages: ${response.total_pages}');
      print('results: ${response.results}');
    });

    test("the response has results more than 0", () async {
      final response = await Remote.fetchMovies();
      final movies = response.results;
      expect(movies.length, greaterThan(0));
    });

    test("the results are structured as the Movie data class", () async {
      final response = await Remote.fetchMovies();
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
        if (movie.genre_ids == null) thereIsNullValue = true;
        if (movie.title == null) thereIsNullValue = true;
        if (movie.vote_average == null) thereIsNullValue = true;
        if (movie.overview == null) thereIsNullValue = true;
        if (movie.release_date == null) thereIsNullValue = true;
      });

      expect(thereIsNullValue, false);

      movies.forEach((movie) {
        print("-------------------");
        print('${movie.popularity}');
        print('${movie.vote_count}');
        print('${movie.isVideo}');
        print('${movie.poster_path}');
        print('${movie.isAdult}');
        print('${movie.backdrop_path}');
        print('${movie.original_language}');
        print('${movie.original_title}');
        print('${movie.genre_ids}');
        print('${movie.title}');
        print('${movie.vote_average}');
        print('${movie.overview}');
        print('${movie.release_date}');
      });
    });
  });
}
