import 'package:shared_preferences/shared_preferences.dart';

class ListStorage {
  static const _favoritesKey = 'favorites';
  static const _watchedKey = 'watched';
  static const _pendingKey = 'pending';

  static Future<Set<int>> _getList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    return list.map((e) => int.parse(e)).toSet();
  }

  static Future<void> _saveList(String key, Set<int> values) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, values.map((e) => e.toString()).toList());
  }

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
