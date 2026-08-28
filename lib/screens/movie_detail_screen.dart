import 'package:catalogopeliculas/models/movie.dart';

import 'package:flutter/material.dart';


class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
        ),
        body:  SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              ),
               Padding(padding: EdgeInsets.all(20),
                child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(movie.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                Text(movie.voteAverage.toString()),
                Text(movie.overview),
                  ],
              ),
             ),
            ],
          ) 
        )
        
    );
  }
}