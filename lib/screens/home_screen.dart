import 'package:flutter/material.dart';

import 'package:catalogmovie/widgets/menu_button.dart';
import 'package:catalogmovie/services/tmdb_service.dart';
import 'package:catalogmovie/models/movie.dart';
import 'package:catalogmovie/services/list_storage.dart';


// Telas
import 'package:catalogmovie/screens/details_screen.dart';
import 'package:catalogmovie/screens/search_history_screen.dart';
import 'package:catalogmovie/screens/watchlist_screen.dart';
import 'package:catalogmovie/screens/watched_screen.dart';
import 'package:catalogmovie/screens/favorites_screen.dart';
import 'package:catalogmovie/screens/about_us_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TmdbService _tmdbService = TmdbService();


  List<Movie> _searchResults = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // --- Buscar filmes ---
  void _searchMovies(String query) async {
    if (query.trim().isEmpty) return;

    await ListStorage.addSearchHistory(query.trim());

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final results = await _tmdbService.searchMovies(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0d253f),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // LOGO
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Image.asset('images/logo.png', height: 100),
                ),
              ),

              // CAMPO DE PESQUISA
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF01b4e4), Color(0xFF90cea1)],
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        _searchResults = [];
                        _errorMessage = '';
                      });
                    }
                  },
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _searchMovies(value);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Procure por seu filme/série',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),

              // RESULTADOS DA PESQUISA
              if (_searchResults.isNotEmpty || _isLoading)
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _errorMessage.isNotEmpty
                      ? Center(
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                      : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final movie = _searchResults[index];

                      return ListTile(
                        leading: movie.posterPath.isNotEmpty
                            ? Image.network(
                          'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                        )
                            : null,
                        title: Text(
                          movie.title,
                          style: const TextStyle(color: Colors.white),
                        ),

                        // Ir para Detalhes do Filme
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsScreen(movieId: movie.id),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

              const SizedBox(height: 15),

              // MENU: Histórico de Pesquisa
              MenuButton(
                icon: Icons.history,
                text: "Histórico de Pesquisa",
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchHistoryScreen(),
                    ),
                  );

                  if (result != null && result is String) {
                    _searchController.text = result;
                    _searchMovies(result);
                  }
                },
              ),

              const SizedBox(height: 7),

              // MENU: Assistir Depois  → WatchlistScreen
              MenuButton(
                icon: Icons.schedule,
                text: "Assistir depois",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WatchlistScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 7),

              // MENU: Já Assistidos → WatchedScreen
              MenuButton(
                icon: Icons.thumb_up_off_alt_outlined,
                text: "Já assistidos",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WatchedScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 7),

              // MENU: Favoritos → FavoritesScreen
              MenuButton(
                icon: Icons.grade_outlined,
                text: "Favoritos",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 100),

              // MENU: Sobre Nós
              Center(
                child: MenuButton(
                  icon: Icons.help_outline,
                  text: "Sobre Nós",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutUsScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
