


import 'package:catalogopeliculas/models/movie.dart';
import 'package:catalogopeliculas/services/movie_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
const HomeScreen({super.key});

@override
State<HomeScreen> createState() => _HomeScreenState();
 
}

class _HomeScreenState extends State<HomeScreen>{

   final MovieService _movieService = MovieService();
  List<Movie> movies = [];

 @override
    void initState() {
      super.initState();
      _movieService.getPopularMovies().then((data){
        setState(() {
          movies = data;
        });
      });  
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ), body: Center(
         child: Text(movies.length.toString()),
      ),
    );
  }
}