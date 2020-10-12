import 'dart:convert';

import 'package:http/http.dart' as http;

class Remote{

  static const API_KEY = "?api_key=8d61230b01928fe55a53a48a41dc839b";
  static const url = "https://api.themoviedb.org/3/movie/popular";
  static const language = "&language=en-US";
  static const page = "&page=1";


  static Future<Map<String, dynamic>> fetchMovies() async {
    final response = await http.get('$url$API_KEY$language$page');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

}





