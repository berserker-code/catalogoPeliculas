import 'package:catalogopeliculas/models/movie.dart';
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

  @override
  void initState() {
    super.initState();
    _movieService.getPopularMovies().then((data) {
      setState(() {
        movies = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data')),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: EdgeInsets.all(5),
            child: Card(
              child: ListTile(
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w200${movie.posterPath}',
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
