import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String _baseUrl = 'https://api.themoviedb.org/3';
  final String _apiKey = '36fd01cdc2a54f3273838051a253d2f5';

  Future<Map<String, dynamic>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load popular movies');
    }
  }
}
