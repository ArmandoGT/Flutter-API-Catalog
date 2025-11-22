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
  late Future<Movie> _futureMovie;

  @override
  void initState() {
    super.initState();
    _futureMovie = fetchMovieDetails();
  }

  Future<Movie> fetchMovieDetails() async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}/movie/${widget.movieId}?api_key=${ApiConfig.apiKey}&language=pt-BR',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar detalhes do filme');
    }
  }

  Widget buildPoster(String? posterPath) {
    if (posterPath != null && posterPath.isNotEmpty) {
      return Image.network(
        'https://image.tmdb.org/t/p/w500$posterPath',
        errorBuilder: (_, __, ___) =>
        const Icon(Icons.image_not_supported, color: Colors.white, size: 60),
      );
    }
    return const Icon(Icons.broken_image, color: Colors.white, size: 60);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Detalhes do Filme'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF01b4e4), Color(0xFF90cea1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      backgroundColor: const Color(0xFF0d253f),

      body: FutureBuilder<Movie>(
        future: _futureMovie,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro: ${snapshot.error}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'Nenhum dado disponível',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final movie = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: buildPoster(movie.posterPath)),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WatchLaterButton(movieId: movie.id),
                    const SizedBox(width: 5),
                    WatchedButton(movieId: movie.id),
                    const SizedBox(width: 5),
                    FavoriteButton(movieId: movie.id),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                Text(
                  movie.formattedGenres,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),

                Text(
                  movie.formattedRuntime,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),

                const SizedBox(height: 8),

                Text(
                  movie.overview,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
