class Movie {
  final int userId;
  final int id;
  final String title;

  Movie({this.userId, this.id, this.title});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}