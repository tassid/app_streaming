import 'package:app_streaming/models/movie.dart';
import 'package:app_streaming/services/api_service.dart';

class MovieRepository {
  final ApiService apiService;

  MovieRepository({required this.apiService});

  Future<List<Movie>> getPopularMovies() async {
    final response = await apiService.getPopularMovies();
    final List results = response['results'];
    return results.map((movie) => Movie.fromJson(movie)).toList();
  }
}
