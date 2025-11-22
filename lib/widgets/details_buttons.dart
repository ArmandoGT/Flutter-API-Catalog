import 'package:flutter/material.dart';
import '../providers/movie_provider.dart';
import 'package:provider/provider.dart';

// --------------------------------------------
// BOTÃO "ASSISTIR DEPOIS"
// --------------------------------------------
class WatchLaterButton extends StatelessWidget {
  final int movieId;
  const WatchLaterButton({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        final isPending = provider.isPending(movieId);

        return ElevatedButton.icon(
          onPressed: () {
            provider.togglePending(movieId);
            _showSnackBar(context, isPending, 'Assistir Depois');
          },
          icon: Icon(
            isPending ? Icons.pending_rounded : Icons.pending_outlined,
            color: Colors.white,
          ),
          label: const Text('Pendente', style: TextStyle(fontSize: 13)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF01b4e4),
            foregroundColor: Colors.white,
          ),
        );
      },
    );
  }
}

// --------------------------------------------
// BOTÃO "JÁ ASSISTIDO"
// --------------------------------------------
class WatchedButton extends StatelessWidget {
  final int movieId;
  const WatchedButton({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        final isWatched = provider.isWatched(movieId);

        return ElevatedButton.icon(
          onPressed: () {
            provider.toggleWatched(movieId);
            _showSnackBar(context, isWatched, 'Já Assistidos');
          },
          icon: Icon(
            isWatched ? Icons.visibility : Icons.visibility_outlined,
            color: Colors.white,
          ),
          label: const Text('Assistido', style: TextStyle(fontSize: 13)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF90cea1),
            foregroundColor: Colors.white,
          ),
        );
      },
    );
  }
}

// --------------------------------------------
// BOTÃO "FAVORITAR"
// --------------------------------------------
class FavoriteButton extends StatelessWidget {
  final int movieId;
  const FavoriteButton({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        final isFavorite = provider.isFavorite(movieId);

        return ElevatedButton.icon(
          onPressed: () {
            provider.toggleFavorite(movieId);
            _showSnackBar(context, isFavorite, 'Favoritos');
          },
          icon: Icon(
            isFavorite ? Icons.star : Icons.star_border,
            color: Colors.white,
          ),
          label: const Text('Favoritar', style: TextStyle(fontSize: 13)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
          ),
        );
      },
    );
  }
}

// Função auxiliar para mostrar a mensagem (SnackBar)
void _showSnackBar(BuildContext context, bool wasActive, String listName) {
  // Usa a chave global ou o Scaffold local se disponível
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        wasActive
            ? 'Removido de $listName'
            : 'Adicionado a $listName',
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
