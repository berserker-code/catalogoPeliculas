import 'dart:async';
import 'package:catalogopeliculas/providers/movie_provider.dart';
import 'package:catalogopeliculas/screens/favorites_screen.dart';
import 'package:catalogopeliculas/screens/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<MovieProvider>().loadPopularMovies();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        context.read<MovieProvider>().loadPopularMovies();
      } else {
        context.read<MovieProvider>().searchMovies(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.watch<MovieProvider>();
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: 'buscar pelicula',
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
            icon: Icon(Icons.favorite, color: Colors.red),
          ),
        ],
      ),

      body: movieProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : movieProvider.errorMessage != null
          ? Center(child: Text(movieProvider.errorMessage!))
          : ListView.builder(
              itemCount: movieProvider.movies.length,
              itemBuilder: (context, index) {
                final movie = movieProvider.movies[index];
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                        ),
                      ),
                      title: Text(movie.title),
                      subtitle: Text(movie.voteAverage.toString()),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(movie: movie),
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
