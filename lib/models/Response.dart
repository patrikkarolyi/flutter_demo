import 'Movie.dart';

class Response {
  final int page;
  final int total_results;
  final int total_pages;
  final List<Movie> results;

  Response({this.page, this.total_results, this.total_pages, this.results});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      page: json['page'],
      total_results: json['total_results'],
      total_pages: json['total_pages'],
      results:(json['results'] as List).map((e) =>  Movie.fromJson(e)).toList(),
    );
  }
}
