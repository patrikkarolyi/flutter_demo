class Genres {
  final List<Genre> value;

  Genres(this.value);

  factory Genres.fromJson(Map<String, dynamic> json) {
    return json['genres'] != null ? Genres(
          (json['genres'] as List).map((e) => Genre.fromJson(e)).toList()) : Genres(List<Genre>());
  }

  String toString() {
    StringBuffer sb = new StringBuffer();
    value.forEach((element) {
      sb.write('${element.name} ');
    });
    return sb.toString();
  }
}

class Genre {
  final num id;
  final String name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}
