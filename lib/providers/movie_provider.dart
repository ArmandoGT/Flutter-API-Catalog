import 'package:flutter/material.dart';
import '../services/list_storage.dart';

class MovieProvider with ChangeNotifier {
  // Listas
  Set<int> _favorites = {};
  Set<int> _watched = {};
  Set<int> _pending = {};

  // Getters
  Set<int> get favorites => _favorites;
  Set<int> get watched => _watched;
  Set<int> get pending => _pending;

  MovieProvider() {
    loadData();
  }

  Future<void> loadData() async {
    _favorites = await ListStorage.getFavorites();
    _watched = await ListStorage.getWatched();
    _pending = await ListStorage.getPending();
    notifyListeners();
  }

  // --- Lógica de Favoritos ---
  bool isFavorite(int id) => _favorites.contains(id);

  Future<void> toggleFavorite(int id) async {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
      await ListStorage.removeFavorite(id);
    } else {
      _favorites.add(id);
      await ListStorage.addFavorite(id);
    }
    notifyListeners();
  }

  // --- Lógica de Já Assistidos ---
  bool isWatched(int id) => _watched.contains(id);

  Future<void> toggleWatched(int id) async {
    if (_watched.contains(id)) {
      _watched.remove(id);
      await ListStorage.removeWatched(id);
    } else {
      _watched.add(id);
      await ListStorage.addWatched(id);
    }
    notifyListeners();
  }

  // --- Lógica de Assistir Depois (Pendente) ---
  bool isPending(int id) => _pending.contains(id);

  Future<void> togglePending(int id) async {
    if (_pending.contains(id)) {
      _pending.remove(id);
      await ListStorage.removePending(id);
    } else {
      _pending.add(id);
      await ListStorage.addPending(id);
    }
    notifyListeners();
  }
}
