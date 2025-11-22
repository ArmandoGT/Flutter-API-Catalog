import 'package:flutter/material.dart';
import '../services/list_storage.dart';

class MovieProvider with ChangeNotifier {
  // Listas em memória para acesso rápido
  Set<int> _favorites = {};
  Set<int> _watched = {};
  Set<int> _pending = {};

  // Getters para acessar as listas
  Set<int> get favorites => _favorites;
  Set<int> get watched => _watched;
  Set<int> get pending => _pending;

  MovieProvider() {
    // Carrega os dados do ListStorage assim que o app abre
    loadData();
  }

  Future<void> loadData() async {
    _favorites = await ListStorage.getFavorites();
    _watched = await ListStorage.getWatched();
    _pending = await ListStorage.getPending();
    notifyListeners(); // Avisa todas as telas que os dados chegaram
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
    notifyListeners(); // Atualiza ícones e abas
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

  // --- Lógica de Assistir Depois (Pendentes) ---
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
