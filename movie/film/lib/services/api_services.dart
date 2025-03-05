import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  static const String apikey = 'c6ec2d98d4844f76a9a5f4ed9854dbbd';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Map<String, dynamic>>> getAllMovie() async {
    return await _fetchMovies('$baseUrl/movie/now_playing?api_key=$apikey');
  }

  Future<List<Map<String, dynamic>>> getTrendingMovie() async {
    return await _fetchMovies('$baseUrl/trending/movie/week?api_key=$apikey');
  }

  Future<List<Map<String, dynamic>>> getPopularMovies() async {
    return await _fetchMovies('$baseUrl/movie/popular?api_key=$apikey');
  }

  Future<List<Map<String, dynamic>>> _fetchMovies(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data.containsKey('results')) {
          return List<Map<String, dynamic>>.from(data['results']);
        } else {
          throw Exception('Invalid JSON format: Missing "results" key');
        }
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching movies: $error');
      return []; // Kembalikan list kosong jika terjadi error
    }
  }
}
