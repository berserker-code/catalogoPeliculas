

import 'package:catalogopeliculas/models/movie.dart';
import 'package:catalogopeliculas/services/favorite_service.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
final FavoriteService _favoriteService = FavoriteService();

List<Movie> _favorites = [];
List<Movie> get favorites => _favorites;
bool _isLoading = true;
bool get isLoading => _isLoading;
String? _errorMessage;
String? get errorMessage => _errorMessage;



Future<void> loadFavorites() async {

  _favoriteService.getFavorites().then((data){
    _favorites = data;
    _isLoading = false;
    notifyListeners();
  }).catchError((error){
    _errorMessage = 'no se cargaron las peliculas favoritas';
    _isLoading = false;
    notifyListeners();
  });
}

Future<void> toggleFavorite(Movie movie) async {  
await _favoriteService.toggleFavorite(movie);
await loadFavorites();

}

bool isFavorite(int id){
  return _favorites.any((movie) => movie.id == id);
}



}