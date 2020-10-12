import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:popular_movies/models/Movie.dart';

class Remote{

  static const API_KEY = "8d61230b01928fe55a53a48a41dc839b";

  static Future<Movie> fetchMovies() async {
    final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');

    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

}





