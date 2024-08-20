import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_streaming/models/movie.dart';

class ApiService {
  final String apiKey = '36fd01cdc2a54f3273838051a253d2f5';
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String language = 'pt-BR'; // Define o idioma para português do Brasil
  final String flaskApiUrl = "http://172.17.0.2:5000/";

  Future<Map<String, String>> _getHeaders() async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<List<Movie>> fetchMoviesFromFlaskAPI(int profileId) async {
    final headers = await _getHeaders();
    final response = await http.get(
        Uri.parse('$flaskApiUrl/profiles/$profileId/movies'),
        headers: headers);

    if (response.statusCode == 200) {
      final List moviesJson = jsonDecode(response.body);
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies from Flask API');
    }
  }

  // Adicionar um filme à lista de filmes do perfil
  Future<void> addMovieToList(int profileId, int movieId, bool liked) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$flaskApiUrl/profiles/$profileId/movies'),
      headers: headers,
      body: json.encode({
        'title': movieId.toString(),
        'liked': liked,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add movie to list');
    }
  }

  // Método para verificar ou criar o perfil no backend Flask
  Future<void> verifyOrCreateUserProfile(String email) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$flaskApiUrl/verify_or_create_profile'),
      headers: headers,
      body: json.encode({'email': email}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to verify or create profile');
    }
  }

  Future<List<Movie>> fetchMovies(String genreId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/discover/movie?api_key=$apiKey&language=$language&with_genres=$genreId'));

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
        return results.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        if (kDebugMode) {
          print('Results is null or not a list');
        }
        return [];
      }
    } else {
      throw Exception('Failed to load movies');
    }
  }

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

  Future<Map<int, String>> fetchGenres() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/genre/movie/list?api_key=$apiKey&language=$language'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List genres = jsonResponse['genres'];

      // Convert the list of genres into a map of ID to name
      return {for (var genre in genres) genre['id']: genre['name']};
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<List<Movie>> fetchMoviesOnboarding(String categoryOrGenreId,
      {bool isGenre = false}) async {
    String url;

    if (isGenre) {
      url =
          '$baseUrl/discover/movie?api_key=$apiKey&language=$language&with_genres=$categoryOrGenreId';
    } else {
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
        return results.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> searchMoviesByTitle({
    required String title,
    bool includeAdult = false,
    String language = 'pt-BR',
    int page = 1,
    String? region,
    String? year,
    String? primaryReleaseYear,
  }) async {
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
