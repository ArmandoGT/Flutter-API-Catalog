import 'package:shared_preferences/shared_preferences.dart';

class ListStorage {
  static const _favoritesKey = 'favorites';
  static const _watchedKey = 'watched';  static const _pendingKey = 'pending';
  static const _historyKey = 'search_history'; // <--- NOVA CHAVE

  static Future<Set<int>> _getList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    return list.map((e) => int.parse(e)).toSet();
  }

  static Future<void> _saveList(String key, Set<int> values) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, values.map((e) => e.toString()).toList());
  }

  // Pegar histórico
  static Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_historyKey) ?? [];
  }

  // Adicionar pesquisa ao histórico
  static Future<void> addSearchHistory(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_historyKey) ?? [];

    // Remove se já existir para colocar no topo
    history.remove(query);
    // Adiciona no início da lista
    history.insert(0, query);

    // Limitado a 20 itens
    if (history.length > 20) {
      history = history.sublist(0, 20);
    }

    await prefs.setStringList(_historyKey, history);
  }

  // Limpar histórico inteiro
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  // Remover um item específico
  static Future<void> removeHistoryItem(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_historyKey) ?? [];
    history.remove(query);
    await prefs.setStringList(_historyKey, history);
  }

  // --------------------------------------

  // Favoritos
  static Future<Set<int>> getFavorites() => _getList(_favoritesKey);
  static Future<void> addFavorite(int movieId) async {
    final list = await getFavorites();
    list.add(movieId);
    await _saveList(_favoritesKey, list);
  }
  static Future<void> removeFavorite(int movieId) async {
    final list = await getFavorites();
    list.remove(movieId);
    await _saveList(_favoritesKey, list);
  }

  // Assistidos
  static Future<Set<int>> getWatched() => _getList(_watchedKey);
  static Future<void> addWatched(int movieId) async {
    final list = await getWatched();
    list.add(movieId);
    await _saveList(_watchedKey, list);
  }
  static Future<void> removeWatched(int movieId) async {
    final list = await getWatched();
    list.remove(movieId);
    await _saveList(_watchedKey, list);
  }

  // Pendentes
  static Future<Set<int>> getPending() => _getList(_pendingKey);
  static Future<void> addPending(int movieId) async {
    final list = await getPending();
    list.add(movieId);
    await _saveList(_pendingKey, list);
  }
  static Future<void> removePending(int movieId) async {
    final list = await getPending();
    list.remove(movieId);
    await _saveList(_pendingKey, list);
  }
}
