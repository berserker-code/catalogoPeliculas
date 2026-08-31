

import 'package:catalogopeliculas/models/movie.dart';
import 'package:catalogopeliculas/screens/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:catalogopeliculas/services/favorite_service.dart';

class FavoritesScreen extends StatefulWidget{
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>{
  final FavoriteService _favoriteService = FavoriteService();
  List<Movie> favorites = [];
  

@override
void initState() {
  super.initState();
  _favoriteService.getFavorites().then((data){
    setState(() {
      favorites = data;
    });
  });
}
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(title: Text('favoritos')),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final movie = favorites[index];
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

