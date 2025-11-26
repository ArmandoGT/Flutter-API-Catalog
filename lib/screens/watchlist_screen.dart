import 'package:flutter/material.dart';
import '../services/list_storage.dart';
import '../models/movie.dart';
import '../services/tmdb_service.dart';
import 'details_screen.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late Future<List<Movie>> _pendingMovies;

  @override
  void initState() {
    super.initState();
    _pendingMovies = _getPendingMovies();
  }

  Future<List<Movie>> _getPendingMovies() async {
    final ids = await ListStorage.getPending();
    return Future.wait(
        ids.map((id) => TmdbService().fetchMovieDetails(id))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0d253f),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () { Navigator.pop(context); },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        title: const Text('Assistir Depois'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF01b4e4), Color(0xFF90cea1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
          ),
        ),
      ),
      body: FutureBuilder<List<Movie>>(
        future: _pendingMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
          }
          final movies = snapshot.data ?? [];

          if (movies.isEmpty) {
            return const Center(
              child: Text(
                'Sua lista está vazia',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, i) {
              final movie = movies[i];
              return ListTile(
                leading: movie.posterPath.isNotEmpty
                    ? Image.network('https://image.tmdb.org/t/p/w92${movie.posterPath}')
                    : null,
                title: Text(movie.title, style: const TextStyle(color: Colors.white)),
                subtitle: Text(movie.formattedGenres, style: const TextStyle(color: Colors.grey)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(movieId: movie.id),
                    ),
                  ).then((_) {
                    setState(() {
                      _pendingMovies = _getPendingMovies();
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
