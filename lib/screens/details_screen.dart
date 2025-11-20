import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../services/api_config.dart';
import '../widgets/details_buttons.dart';

class DetailsScreen extends StatefulWidget {
  final int movieId;

  const DetailsScreen({super.key, required this.movieId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<Movie> fetchMovieDetails() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/movie/${widget.movieId}?api_key=${ApiConfig.apiKey}&language=pt-BR');
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
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,)),
        title: const Text('Detalhes do Filme'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors:[
                Color(0xFF01b4e4),
                Color(0xFF90cea1),
              ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,)
          ),
        ),), // Fim da App Bar

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
                children: [ //Botões Pendente, Assistido e Favoritar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: WatchLaterButton()),
                      const SizedBox(width: 5),
                      Expanded(child: WatchedButton()),
                      const SizedBox(width: 5),
                      Expanded(child: FavoriteButton()),
                    ],
                  ),

                  const SizedBox(height: 16), // Espaço antes do pôster

                  if (movie.posterPath.isNotEmpty) // Pôster
                    Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                  const SizedBox(height: 16),
                  Text(movie.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)), // Título
                  Text(movie.formattedGenres, style: const TextStyle(fontSize: 16, color: Colors.white)), // Gênero do filme
                  Text(movie.formattedRuntime, style: const TextStyle(fontSize: 16, color: Colors.white)), // Duração
                  const SizedBox(height: 5),
                  Text(movie.overview, style: const TextStyle(fontSize: 16, color: Colors.white)), // Sinopse
                  const SizedBox(height: 16),
                  Center(child: Text('Produtoras:', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))), // Produtoras
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
                  }) // FimProdutoras
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
