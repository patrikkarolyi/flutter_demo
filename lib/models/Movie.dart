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
  final List<dynamic> genre_ids;
  final String title;
  final num vote_average;
  final String overview;
  final String release_date;

  Movie(
      {this.popularity,
      this.vote_count,
      this.isVideo,
      this.poster_path,
      this.id,
      this.isAdult,
      this.backdrop_path,
      this.original_language,
      this.original_title,
      this.genre_ids,
      this.title,
      this.vote_average,
      this.overview,
      this.release_date});

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
      genre_ids: json['genre_ids'],
      title: json['title'],
      vote_average: json['vote_average'],
      overview: json['overview'],
      release_date: json['release_date'],
    );
  }
}
