import 'package:catalogopeliculas/models/movie.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  Future<List<Movie>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favoritesJson = prefs.getStringList('favorites') ?? [];

    List<Movie> movies = favoritesJson.map((unString) {
      Map<String, dynamic> movieMap = jsonDecode(unString);
      Movie movie = Movie.fromJson(movieMap);
      return movie;
    }).toList();
    return movies;
  }

  Future<bool>isFavorites(int id) async{
    List<Movie> favorites = await getFavorites();
    bool esFavorita = favorites.any((movie)=> movie.id == id);
    return esFavorita;
  }

  Future<void> toggleFavorite(Movie movie)async{
    final prefs = await SharedPreferences.getInstance();
    List<Movie> favorites = await getFavorites();
    bool existe = favorites.any((m)=> m.id == movie.id);
    List<String> favoritesJson = prefs.getStringList('favorites') ?? [];
      if(existe == true){
        favoritesJson.removeWhere((unString){
        Map<String, dynamic> movieMap = jsonDecode(unString);
        Movie savedMovie = Movie.fromJson(movieMap);
        return savedMovie.id == movie.id;
        });
      }else{
        favoritesJson.add(jsonEncode(movie.toJson()));
      }

      await prefs.setStringList('favorites', favoritesJson);
      }







}
