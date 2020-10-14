import 'package:popular_movies/models/utils/Utils.dart';

import 'Genres.dart';

class Movie {
  final num popularity;
  final num vote_count;
  final bool isVideo;
  final String poster_path;
  final num id;
  final bool isAdult;
  final String backdrop_path;
  final String original_language;
  final String original_title;
  final String title;
  final num vote_average;
  final String overview;
  final String release_date;

  final Genres genres;
  final num runtime;

  Movie({
    this.popularity,
    this.vote_count,
    this.isVideo,
    this.poster_path,
    this.id,
    this.isAdult,
    this.backdrop_path,
    this.original_language,
    this.original_title,
    this.genres,
    this.title,
    this.vote_average,
    this.overview,
    this.release_date,
    this.runtime,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      popularity: json['popularity'],
      vote_count: json['vote_count'],
      isVideo: json['video'],
      poster_path: json['poster_path'],
      id: json['id'],
      isAdult: json['adult'],
      backdrop_path: json['backdrop_path'],
      original_language: json['original_language'],
      original_title: json['original_title'],
      genres: Genres.fromJson(json),
      title: json['title'],
      vote_average: json['vote_average'],
      overview: json['overview'],
      release_date: json['release_date'],
      runtime: json['runtime'],
    );
  }

  void printMovie() {
    print("-------------------");
    print('${this.popularity}');
    print('${this.vote_count}');
    print('${this.isVideo}');
    print('${this.poster_path}');
    print('${this.isAdult}');
    print('${this.backdrop_path}');
    print('${this.original_language}');
    print('${this.original_title}');
    print('${this.genres.toString()}');
    print('${this.title}');
    print('${this.vote_average}');
    print('${this.overview}');
    print('${this.release_date}');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'popularity': popularity,
      'vote_count': vote_count,
      'is_video': boolToInt(isVideo),
      'poster_path': poster_path,
      'is_adult': isAdult,
      'backdrop_path': backdrop_path,
      'original_language': original_language,
      'original_title': original_title,
      'title': title,
      'vote_average': vote_average,
      'overview': overview,
      'release_date': release_date,
      'runtime': runtime,
    };
  }
}
