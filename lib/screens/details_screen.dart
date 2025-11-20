import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../services/api_config.dart';

class DetailsScreen extends StatelessWidget {
  final int movieId;

  const DetailsScreen({super.key, required this.movieId});

  Future<Movie> fetchMovieDetails() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/movie/$movieId?api_key=${ApiConfig.apiKey}&language=pt-BR');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Movie.fromJson(json);
    } else {
      throw Exception('Falha ao carregar detalhes do filme');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Filme')),
      backgroundColor: const Color(0xFF0d253f),
      body: FutureBuilder<Movie>(
        future: fetchMovieDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
          } else if (snapshot.hasData) {
            final movie = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (movie.posterPath.isNotEmpty)
                    Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                  const SizedBox(height: 16),
                  Text(movie.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(movie.formattedGenres, style: const TextStyle(fontSize: 16, color: Colors.white)),
                  Text(movie.formattedRuntime, style: const TextStyle(fontSize: 16, color: Colors.white)),
                  const SizedBox(height: 5),
                  Text(movie.overview, style: const TextStyle(fontSize: 16, color: Colors.white)),
                  const SizedBox(height: 16),
                  Center(child: Text('Produtoras:', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                  if (movie.productionCompanies.isEmpty)
                    const Text('Nenhuma produtora encontrada', style: TextStyle(color: Colors.white)),
                  ...movie.productionCompanies.map((company) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (company.logoPath != null)
                            Image.network(
                              'https://image.tmdb.org/t/p/w45${company.logoPath}',
                              width: 80,
                              height: 30,
                              fit: BoxFit.contain,
                            ),
                          if (company.logoPath != null) const SizedBox(width: 8),
                          Text('${company.name} (${company.originCountry})',
                    style: const TextStyle(color: Colors.white),),
                        ],
                      ),
                    );
                  })
                ],
              ),
            );

          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
