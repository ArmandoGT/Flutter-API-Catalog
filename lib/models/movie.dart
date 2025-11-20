class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final List<String> genres;
  final int runtime;
  final List<ProductionCompany> productionCompanies;


  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.genres,
    required this.runtime,
    required this.productionCompanies,

  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<String> genresList = [];

    if (json['genres'] != null && json['genres'] is List) {
      genresList = (json['genres'] as List)
          .map((g) => (g['name'] ?? '').toString())
          .where((name) => name.isNotEmpty)
          .toList();
    }

    List<ProductionCompany> companiesList = [];
    if (json['production_companies'] != null && json['production_companies'] is List) {
      companiesList = (json['production_companies'] as List)
          .map((c) => ProductionCompany.fromJson(c))
          .toList();
    }


    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Sem título',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? 'Descrição não disponível',
      genres: genresList,
      runtime: json['runtime'] ?? 0,
      productionCompanies: companiesList,
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

class ProductionCompany {
  final int id;
  final String name;
  final String? logoPath;
  final String originCountry;

  ProductionCompany({
    required this.id,
    required this.name,
    this.logoPath,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logoPath: json['logo_path'],
      originCountry: json['origin_country'] ?? '',
    );
  }
}
