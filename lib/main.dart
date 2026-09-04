import 'package:catalogopeliculas/providers/favorite_provider.dart';
import 'package:catalogopeliculas/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart'; // ajusta según el nombre real de tu pantalla

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => MovieProvider()),
      ChangeNotifierProvider(create: (context) => FavoriteProvider()),
    ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Movie App',
      home: HomeScreen(),
    ),
    
    );
  }
}

