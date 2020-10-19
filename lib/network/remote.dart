import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:popular_movies/models/data/movie.dart';
import 'package:popular_movies/models/data/response.dart';


class Remote{

  static const API_KEY = "?api_key=8d61230b01928fe55a53a48a41dc839b";
  static const urlPopular = "https://api.themoviedb.org/3/movie/popular";
  static const urlTopRated = "https://api.themoviedb.org/3/movie/top_rated";
  static const urlDetails = "https://api.themoviedb.org/3/movie/";
  static const language = "&language=en-US";
  static const page = "&page=1";
  static const image_url_small= "https://image.tmdb.org/t/p/w342/";
  static const image_url_large= "https://image.tmdb.org/t/p/original/";


  static Future<Response> fetchPopularMovies() async {
    final response = await http.get('$urlPopular$API_KEY$language$page');

    if (response.statusCode == 200) {
      return Response.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<Response> fetchTopRatedMovies() async {
    final response = await http.get('$urlTopRated$API_KEY$language$page');

    if (response.statusCode == 200) {
      return Response.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<Movie> fetchMovie(num id) async {
  final response = await http.get('$urlDetails$id$API_KEY$language$page');

  if (response.statusCode == 200) {
  return Movie.fromJson(jsonDecode(response.body));
  } else {
  throw Exception('Failed to load album');
  }
}
}





