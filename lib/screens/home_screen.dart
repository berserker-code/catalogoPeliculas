import 'dart:async';

import 'package:catalogopeliculas/models/movie.dart';
import 'package:catalogopeliculas/screens/favorites_screen.dart';
import 'package:catalogopeliculas/screens/movie_detail_screen.dart';
import 'package:catalogopeliculas/services/movie_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieService _movieService = MovieService();
  List<Movie> movies = [];
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;
  bool isLoading = true;
  String? errorMessage;


  @override
  void initState() {
    super.initState();
    _movieService.getPopularMovies().then((data) {
      setState(() {
        movies = data;
        isLoading = false;
      });
    }).catchError((error){
      setState(() {
        errorMessage = 'no se cargaron las peliculas';
        isLoading = false;
      });
    });
  }

  @override
  void dispose(){
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query){
    if(_debounce?.isActive ?? false )  _debounce!.cancel();
  _debounce = Timer(const Duration(milliseconds: 500), (){
    if (query.isEmpty){
          _movieService.getPopularMovies().then((data) {
      setState(() {
        movies = data;
        isLoading = false;
      });
    });
    }else{
          _movieService.searchMovies(query).then((data) {
      setState(() {
        movies = data;
        isLoading = false;
      });
    }).catchError((error){
      setState(() {
        errorMessage = 'no se cargaron las peliculas';
        isLoading = false;
      });
    });
    }
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: 'buscar pelicula',
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.black,),
      ) ,
      actions: [
        IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>FavoritesScreen()));
        }, icon: Icon(Icons.favorite, color: Colors.red,))
      ],),


      body: isLoading
      ? Center(child: CircularProgressIndicator())
      : errorMessage != null
        ? Center(child: Text(errorMessage!))
        : ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: EdgeInsets.all(5),
            child: Card(
              elevation: 4, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: ClipRRect( borderRadius: BorderRadius.circular(8),
                child: 
                Image.network(
                  'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                ),
                ),
                title: Text(movie.title),
                subtitle: Text(movie.voteAverage.toString()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(movie: movie),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
