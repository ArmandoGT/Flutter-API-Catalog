import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import 'api_config.dart';

class TmdbService {
  // Método já existente
  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/search/movie?api_key=${ApiConfig.apiKey}&language=pt-BR&query=$query');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar filmes');
    }
  }

  // Novo método para buscar detalhes por ID
  Future<Movie> fetchMovieDetails(int movieId) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/movie/$movieId?api_key=${ApiConfig.apiKey}&language=pt-BR');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao buscar detalhes do filme');
    }
  }
}
