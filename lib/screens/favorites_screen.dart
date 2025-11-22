import 'package:flutter/material.dart';
import '../services/list_storage.dart';
import '../models/movie.dart';
import '../services/tmdb_service.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<Movie>> _favoriteMovies;

  @override
  void initState() {
    super.initState();
    _favoriteMovies = _getFavoriteMovies();
  }

  Future<List<Movie>> _getFavoriteMovies() async {
    final ids = await ListStorage.getFavorites();
    // Busca detalhes de todos os filmes pelo ID (exemplo usando sua TmdbService)
    return Future.wait(
        ids.map((id) => TmdbService().fetchMovieDetails(id))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: _favoriteMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Erro: ${snapshot.error}'));
          final movies = snapshot.data ?? [];
          if (movies.isEmpty)
            return const Center(child: Text('Nenhum filme favorito'));
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, i) {
              final movie = movies[i];
              return ListTile(
                leading: movie.posterPath.isNotEmpty
                    ? Image.network('https://image.tmdb.org/t/p/w92${movie.posterPath}')
                    : null,
                title: Text(movie.title),
                subtitle: Text(movie.formattedGenres),
                onTap: () {
                  // Navegue para tela de detalhes, se desejar
                },
              );
            },
          );
        },
      ),
    );
  }
}
