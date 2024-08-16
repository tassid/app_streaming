import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:app_streaming/models/movie.dart';

class ApiService {
  final String apiKey = '36fd01cdc2a54f3273838051a253d2f5';
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String language = 'pt-BR'; // Define o idioma para português do Brasil

  // Função para buscar filmes por categoria (ex: popular, top_rated)
  Future<List<Movie>> fetchMovies(String category) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/movie/$category?api_key=$apiKey&language=$language'));

    // Adicionar impressão de debug para verificar a resposta da API
    if (kDebugMode) {
      print('Response status: ${response.statusCode}');
    }
    if (kDebugMode) {
      print('Response body: ${response.body}');
    }

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      // Verifique se a chave 'results' existe e não é null
      if (jsonResponse['results'] != null && jsonResponse['results'] is List) {
        final List results = jsonResponse['results'];

        if (results.isNotEmpty) {
          return results.map((movie) => Movie.fromJson(movie)).toList();
        } else {
          return []; // Retorna uma lista vazia se não houver resultados
        }
      } else {
        if (kDebugMode) {
          print('Results is null or not a list');
        }
        return []; // Retorna uma lista vazia se 'results' for null ou não for uma lista
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

  getPopularMovies() {}
}
