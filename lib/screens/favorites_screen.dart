import 'package:flutter/material.dart';
import '../services/list_storage.dart';
import '../models/movie.dart';
import '../services/tmdb_service.dart';
import 'details_screen.dart';

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
    // Busca detalhes de todos os filmes pelo ID
    return Future.wait(
        ids.map((id) => TmdbService().fetchMovieDetails(id))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,)),
        title: const Text('Favoritos'),
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
        ),),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(movieId: movie.id),
                    ),
                  ).then((_) {

                    setState(() {
                      _favoriteMovies = _getFavoriteMovies();
                    });
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
