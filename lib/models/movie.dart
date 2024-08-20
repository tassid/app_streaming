class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final List<Genre> genres;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    // Handle the genres, ensuring we correctly parse them if present
    final genresJson = json['genres'] as List<dynamic>?;

    return Movie(
      id: json['id'],
      title: json['title'] ?? 'Título desconhecido',
      overview: json['overview'] ?? 'Sem descrição disponível',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      genres: genresJson != null
          ? genresJson.map((genre) => Genre.fromJson(genre)).toList()
          : [], // Return an empty list if there are no genres
    );
  }

  get imageUrl => null;

  String getPosterUrl() {
    return posterPath.isNotEmpty
        ? 'https://image.tmdb.org/t/p/w500$posterPath'
        : 'https://via.placeholder.com/500'; // Fallback for missing poster
  }

  String getBackdropUrl() {
    return backdropPath.isNotEmpty
        ? 'https://image.tmdb.org/t/p/w780$backdropPath'
        : 'https://via.placeholder.com/780'; // Fallback for missing backdrop
  }

  String getFormattedReleaseDate() {
    return releaseDate.isNotEmpty
        ? releaseDate
        : 'Data de lançamento desconhecida';
  }

  String getVoteAverageText() {
    return '$voteAverage/10';
  }
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}
