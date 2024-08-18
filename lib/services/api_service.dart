import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:app_streaming/models/movie.dart';

class ApiService {
  final String apiKey = '36fd01cdc2a54f3273838051a253d2f5';
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String language = 'pt-BR'; // Define o idioma para português do Brasil

  Future<List<Movie>> fetchMovies(String genreId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/discover/movie?api_key=$apiKey&language=$language&with_genres=$genreId'));

    // Add debugging information
    if (kDebugMode) {
      print('Fetching movies for genre ID: $genreId');
      print(
          'API URL: $baseUrl/discover/movie?api_key=$apiKey&language=$language&with_genres=$genreId');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['results'] != null && jsonResponse['results'] is List) {
        final List results = jsonResponse['results'];

        if (results.isNotEmpty) {
          return results.map((movie) => Movie.fromJson(movie)).toList();
        } else {
          return []; // No results
        }
      } else {
        if (kDebugMode) {
          print('Results is null or not a list');
        }
        return []; // Results is null or not a list
      }
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // Função para buscar os detalhes de um filme
  Future<Movie> fetchMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/movie/$movieId?api_key=$apiKey&language=$language&append_to_response=videos'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Movie.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  // Função para buscar o trailer de um filme
  Future<String> fetchTrailer(int movieId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/movie/$movieId/videos?api_key=$apiKey&language=$language'));

    if (response.statusCode == 200) {
      final List videos = jsonDecode(response.body)['results'];
      final trailer = videos.firstWhere((video) => video['type'] == 'Trailer',
          orElse: () => null);
      return trailer != null
          ? 'https://www.youtube.com/watch?v=${trailer['key']}'
          : '';
    } else {
      throw Exception('Failed to load trailer');
    }
  }

  // Método para buscar filmes relacionados
  Future<List<Movie>> fetchRelatedMovies(int movieId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/movie/$movieId/similar?api_key=$apiKey&language=$language'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List results = jsonResponse['results'];

      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load related movies');
    }
  }

  // Função para buscar todos os gêneros de filmes
  Future<Map<int, String>> fetchGenres() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/genre/movie/list?api_key=$apiKey&language=$language'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List genres = jsonResponse['genres'];

      // Converta a lista de gêneros em um mapa de ID para nome
      return {for (var genre in genres) genre['id']: genre['name']};
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<List<Movie>> fetchMoviesOnboarding(String categoryOrGenreId,
      {bool isGenre = false}) async {
    String url;

    if (isGenre) {
      // If it's a genre, use the discover endpoint with genres
      url =
          '$baseUrl/discover/movie?api_key=$apiKey&language=$language&with_genres=$categoryOrGenreId';
    } else {
      // If it's a predefined category (e.g., popular), use the specific endpoint
      url =
          '$baseUrl/movie/$categoryOrGenreId?api_key=$apiKey&language=$language';
    }

    final response = await http.get(Uri.parse(url));

    if (kDebugMode) {
      print('Fetching movies for $categoryOrGenreId');
      print('API URL: $url');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['results'] != null && jsonResponse['results'] is List) {
        final List results = jsonResponse['results'];

        if (results.isNotEmpty) {
          return results.map((movie) => Movie.fromJson(movie)).toList();
        } else {
          return [];
        }
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> searchMoviesByTitle(
      {required String title,
      bool includeAdult = false,
      String language = 'pt-BR',
      int page = 1,
      String? region,
      String? year,
      String? primaryReleaseYear}) async {
    final Uri uri = Uri.parse(
      '$baseUrl/search/movie',
    ).replace(queryParameters: {
      'api_key': apiKey,
      'query': title,
      'include_adult': includeAdult.toString(),
      'language': language,
      'page': page.toString(),
      if (region != null) 'region': region,
      if (year != null) 'year': year,
      if (primaryReleaseYear != null)
        'primary_release_year': primaryReleaseYear,
    });

    final response = await http.get(uri);

    if (kDebugMode) {
      print('Search URL: ${uri.toString()}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['results'] != null && jsonResponse['results'] is List) {
        final List results = jsonResponse['results'];
        return results.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to search movies');
    }
  }

  getPopularMovies() {}
}
