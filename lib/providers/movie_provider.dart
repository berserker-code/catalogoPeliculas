import 'package:catalogopeliculas/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:catalogopeliculas/services/movie_service.dart';

class MovieProvider extends ChangeNotifier{
  final MovieService _movieService = MovieService();


  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  Future<void> loadPopularMovies() async {
    _isLoading = true;
    notifyListeners();



    _movieService.getPopularMovies().then((data){
      _movies = data;
      _isLoading = false;
      notifyListeners();
    }).catchError((error){
      _errorMessage = 'no se cargaron las peliculas';
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> searchMovies(String query) async {
    _isLoading = true;
    notifyListeners();

    _movieService.searchMovies(query).then((data){
      _movies = data;
      _isLoading = false;
      notifyListeners();
    }).catchError((error){
      _errorMessage = 'no se encontraron peliculas';
      _isLoading = false;
      notifyListeners();
    });


  }

}