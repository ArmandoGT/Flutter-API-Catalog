class MovieModel {
  final int movieId;
  final String title;
  final String posterPath;
  final String listType; // "favorite", "watched", "pending"

  MovieModel({
    required this.movieId,
    required this.title,
    required this.posterPath,
    required this.listType,
  });

  factory MovieModel.fromMap(Map<String, dynamic> map) => MovieModel(
    movieId: map['movieId'],
    title: map['title'],
    posterPath: map['posterPath'],
    listType: map['listType'],
  );

  Map<String, dynamic> toMap() => {
    'movieId': movieId,
    'title': title,
    'posterPath': posterPath,
    'listType': listType,
  };
}
