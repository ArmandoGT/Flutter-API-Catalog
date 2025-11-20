class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final List<String> genres;
  final int runtime;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.genres,
    required this.runtime
  });

  // Factory para criar Movie a partir de JSON da API TMDb
  factory Movie.fromJson(Map<String, dynamic> json) {
    List<String> genresList = [];

    // Se 'genres' está presente e é uma lista, extrai só os nomes
    if (json['genres'] != null && json['genres'] is List) {
      genresList = (json['genres'] as List)
          .map((g) => (g['name'] ?? '').toString())
          .where((name) => name.isNotEmpty)
          .toList();
    }

    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Sem título',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? 'Descrição não disponível',
      genres: genresList,
      runtime: json['runtime'] ?? 0,
    );
  }

  String get formattedGenres {
    if (genres.isEmpty) {
      return 'Gênero: Não encontrado';
    } else {
      return 'Gênero: ${genres.join(', ')}';
    }
  }

  String get formattedRuntime {
    if (runtime <= 0) return 'Duração: Não disponível';
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    return 'Duração: ${hours}h ${minutes}m';
  }

}
