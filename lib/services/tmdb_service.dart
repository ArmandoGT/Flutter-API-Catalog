import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import 'api_config.dart';

class TmdbService {
  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.parse(ApiConfig.searchMoviesUrl(query));
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar filmes');
    }
  }
}
