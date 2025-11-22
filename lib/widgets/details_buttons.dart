import 'package:flutter/material.dart';
import '../services/list_storage.dart';

// --------------------------------------------
// BOTÃO "ASSISTIR DEPOIS"
// --------------------------------------------
class WatchLaterButton extends StatefulWidget {
  final int movieId;
  const WatchLaterButton({super.key, required this.movieId});

  @override
  State<WatchLaterButton> createState() => _WatchLaterButtonState();
}

class _WatchLaterButtonState extends State<WatchLaterButton> {
  bool added = false;

  @override
  void initState() {
    super.initState();
    _checkState();
  }

  Future<void> _checkState() async {
    final pending = await ListStorage.getPending();
    if (mounted) {
      setState(() => added = pending.contains(widget.movieId));
    }
  }

  Future<void> _toggle(BuildContext context) async {
    final wasAdded = added;
    setState(() => added = !added);

    if (wasAdded) {
      await ListStorage.removePending(widget.movieId);
    } else {
      await ListStorage.addPending(widget.movieId);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          !wasAdded
              ? 'Adicionado à lista Assistir Depois'
              : 'Removido de Assistir Depois',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _toggle(context),
      icon: Icon(
        added ? Icons.pending_rounded : Icons.pending_outlined,
        color: Colors.white,
      ),
      label: const Text('Pendente', style: TextStyle(fontSize: 13)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF01b4e4),
        foregroundColor: Colors.white,
      ),
    );
  }
}

// --------------------------------------------
// BOTÃO "JÁ ASSISTIDO"
// --------------------------------------------
class WatchedButton extends StatefulWidget {
  final int movieId;
  const WatchedButton({super.key, required this.movieId});

  @override
  State<WatchedButton> createState() => _WatchedButtonState();
}

class _WatchedButtonState extends State<WatchedButton> {
  bool marked = false;

  @override
  void initState() {
    super.initState();
    _checkState();
  }

  Future<void> _checkState() async {
    final watched = await ListStorage.getWatched();
    if (mounted) {
      setState(() => marked = watched.contains(widget.movieId));
    }
  }

  Future<void> _toggle(BuildContext context) async {
    final wasMarked = marked;
    setState(() => marked = !marked);

    if (wasMarked) {
      await ListStorage.removeWatched(widget.movieId);
    } else {
      await ListStorage.addWatched(widget.movieId);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          !wasMarked
              ? 'Marcado como já assistido'
              : 'Desmarcado como assistido',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _toggle(context),
      icon: Icon(
        marked ? Icons.visibility : Icons.visibility_outlined,
        color: Colors.white,
      ),
      label: const Text('Assistido', style: TextStyle(fontSize: 13)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF90cea1),
        foregroundColor: Colors.white,
      ),
    );
  }
}

// --------------------------------------------
// BOTÃO "FAVORITAR"
// --------------------------------------------
class FavoriteButton extends StatefulWidget {
  final int movieId;
  const FavoriteButton({super.key, required this.movieId});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool favorite = false;

  @override
  void initState() {
    super.initState();
    _checkState();
  }

  Future<void> _checkState() async {
    final favorites = await ListStorage.getFavorites();
    if (mounted) {
      setState(() => favorite = favorites.contains(widget.movieId));
    }
  }

  Future<void> _toggle(BuildContext context) async {
    final wasFavorite = favorite;
    setState(() => favorite = !favorite);

    if (wasFavorite) {
      await ListStorage.removeFavorite(widget.movieId);
    } else {
      await ListStorage.addFavorite(widget.movieId);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          !wasFavorite
              ? 'Adicionado aos favoritos'
              : 'Removido dos favoritos',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _toggle(context),
      icon: Icon(
        favorite ? Icons.star : Icons.star_border,
        color: Colors.white,
      ),
      label: const Text('Favoritar', style: TextStyle(fontSize: 13)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
    );
  }
}
