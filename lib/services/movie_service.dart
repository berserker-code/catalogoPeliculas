import 'dart:convert';

import 'package:catalogopeliculas/config/api_key.dart';
import 'package:catalogopeliculas/models/movie.dart';
import 'package:http/http.dart' as http;

class MovieService {
  final String _baseUrl = 'api.themoviedb.org';

  Future<List<Movie>> getPopularMovies() async {
    final url = Uri.https(_baseUrl, '/3/movie/popular', {
      'api_key': apikey,
      'language': 'es-ES',
      'page': '1',
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> results = data['results'];
      List<Movie> movies = results
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList();
      return movies;
    } else {
       throw Exception('error');
    }
  }

    Future<List<Movie>> searchMovies( String query) async {
    final url = Uri.https(_baseUrl, '/3/search/movie', {
      'query': query,
      'api_key': apikey,
      'language': 'es-ES',
      'page': '1',
    });

    final response = await http.get(url);
      if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> results = data['results'];
      List<Movie> movies = results
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList();
      return movies;
    } else {
       throw Exception('error');
    }
    }
}
