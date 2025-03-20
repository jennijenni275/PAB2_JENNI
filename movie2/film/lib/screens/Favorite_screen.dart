import 'dart:convert';
import 'package:film/models/movie.dart';  // Mengimpor model Movie dari folder models
import 'package:film/screens/detail_screen.dart';  // Mengimpor DetailScreen dari folder screens
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Movie> _FavoriteMovies = [];

  Future<void> _loadFavoriteMovie() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> favoriteMovieIds =
      prefs.getKeys().where((key) => key.startsWith('movie_')).toList();
      print('favoriteMovieIds: $favoriteMovieIds');
      setState(() {
        _FavoriteMovies = favoriteMovieIds
        .map((id) {
          final String? movieJson = prefs.getString(id);
          if (movieJson != null && movieJson.isNotEmpty){
            final Map<String, dynamic> movieData = jsonDecode(movieJson);
            return Movie.fromJson(movieData);
          }
          return null;
        })
        .where((movie) => movie != null )
        .cast<Movie>()
        .toList();
      });
  }
  @override
  void initState(){
    super.initState();
    _loadFavoriteMovie();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movie'),
      ),
      body: ListView.builder(
        itemCount: _FavoriteMovies.length,
        itemBuilder: (context, index) {
          final Movie movie = _FavoriteMovies[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: Image.network(
                movie.posterPath != ''
                    ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                    : 'https://placehold.co/50x75?text=No+Image',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(movie.title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(movie: movie),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}