import 'package:catalogopeliculas/models/movie.dart';
import 'package:catalogopeliculas/services/favorite_service.dart';

import 'package:flutter/material.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movie});

  final Movie movie;
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}


class _MovieDetailScreenState extends State<MovieDetailScreen> {

final FavoriteService _favoriteService = FavoriteService();
bool isFavorite = false;

@override
  void initState() {
    super.initState();
    _favoriteService.isFavorites(widget.movie.id).then((value){
      setState(() {
        isFavorite = value;
      });
    });

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text(widget.movie.title),
      actions: [
        IconButton(onPressed: (){
          _favoriteService.toggleFavorite(widget.movie).then((_){
            setState(() {
              isFavorite = !isFavorite;
            });
          });
        }, icon: Icon(isFavorite ? Icons.favorite: Icons.favorite_border,
        color: isFavorite ? Colors.red : null,))
      ],),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network('https://image.tmdb.org/t/p/w500${widget.movie.posterPath}'),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.movie.voteAverage.toString()),
                  Text(widget.movie.overview),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
