import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/movie_model.dart';

class MovieDB {
  static final MovieDB instance = MovieDB._init();
  static Database? _database;

  MovieDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movie_lists.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movie_lists (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        movieId INTEGER NOT NULL,
        title TEXT NOT NULL,
        posterPath TEXT NOT NULL,
        listType TEXT NOT NULL
      )
    ''');
  }

  Future<void> addMovie(MovieModel movie) async {
    final db = await instance.database;
    await db.insert(
      'movie_lists',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeMovie(int movieId, String listType) async {
    final db = await instance.database;
    await db.delete(
      'movie_lists',
      where: 'movieId = ? AND listType = ?',
      whereArgs: [movieId, listType],
    );
  }

  Future<List<MovieModel>> getMovies(String listType) async {
    final db = await instance.database;
    final maps = await db.query(
      'movie_lists',
      where: 'listType = ?',
      whereArgs: [listType],
    );
    return maps.map((e) => MovieModel.fromMap(e)).toList();
  }

  Future<bool> isOnList(int movieId, String listType) async {
    final db = await instance.database;
    final result = await db.query(
      'movie_lists',
      where: 'movieId = ? AND listType = ?',
      whereArgs: [movieId, listType],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
