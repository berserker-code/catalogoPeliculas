import 'package:catalogopeliculas/models/movie.dart';
import 'package:catalogopeliculas/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movie});

  final Movie movie;
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}


class _MovieDetailScreenState extends State<MovieDetailScreen> {


@override
  void initState() {
    super.initState();
    context.read<FavoriteProvider>().loadFavorites();
    }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProvider>();
    
    return Scaffold(
      
      appBar: AppBar(title: Text(widget.movie.title),
      actions: [
        IconButton(onPressed: (){
            favoriteProvider.toggleFavorite(widget.movie);
            },
            icon: Icon(favoriteProvider.isFavorite(widget.movie.id) ? Icons.favorite: Icons.favorite_border,
        color: favoriteProvider.isFavorite(widget.movie.id) ? Colors.red : null,),
        ),
      ],
      ),
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
