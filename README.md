# catalogopeliculas

A new Flutter project.

## Getting Started

🎬 Catálogo de Películas

App móvil desarrollada en Flutter que consume la API pública de The Movie Database (TMDB) para mostrar películas populares, permitir búsquedas en tiempo real, ver el detalle de cada título y guardar favoritos de forma persistente en el dispositivo.

Este proyecto fue creado como práctica personal para profundizar los conocimientos adquiridos en un curso de Flutter y Dart, aplicando conceptos reales de consumo de APIs, manejo de estado, navegación y persistencia local.

📱 Capturas de pantalla
<!-- Agrega aquí 3-4 capturas de tu app. Ejemplo: --> <!-- <p float="left"> <img src="screenshots/home.png" width="200" /> <img src="screenshots/detail.png" width="200" /> <img src="screenshots/favorites.png" width="200" /> </p> -->
✨ Funcionalidades
🎥 Lista de películas populares consumidas desde la API de TMDB
🔍 Buscador de películas por título en tiempo real (con debounce)
📄 Pantalla de detalle con póster, sinopsis y calificación
❤️ Marcar/desmarcar películas como favoritas
💾 Persistencia local de favoritos con SharedPreferences (se mantienen aunque cierres la app)
⏳ Manejo de estados de carga y error de conexión
🛠️ Tecnologías y paquetes
Flutter & Dart
http — consumo de la API REST de TMDB
shared_preferences — persistencia local de datos
StatefulWidget + setState — manejo de estado
Navigator — navegación entre pantallas con paso de datos
🏗️ Estructura del proyecto
lib/
├── config/
│   └── api_key.dart          # API key (no versionado, ver instalación)
├── models/
│   └── movie.dart            # Modelo de datos Movie (fromJson/toJson)
├── services/
│   ├── movie_service.dart    # Consumo de la API de TMDB
│   └── favorite_service.dart # Lógica de favoritos con SharedPreferences
├── screens/
│   ├── home_screen.dart          # Lista principal + buscador
│   ├── movie_detail_screen.dart  # Detalle de película + favorito
│   └── favorites_screen.dart     # Lista de favoritos guardados
└── main.dart
🚀 Instalación y ejecución
Clona el repositorio:
bash
   git clone https://github.com/berserker-code/catalogoPeliculas.git
   cd catalogoPeliculas
Instala las dependencias:
bash
   flutter pub get
Consigue una API key gratuita en TMDB (Configuración > API).
Crea el archivo lib/config/api_key.dart con el siguiente contenido, reemplazando con tu propia key:
dart
   const String apikey = 'TU_API_KEY_AQUI';
Corre la app:
bash
   flutter run
📚 Aprendizajes clave de este proyecto
Consumo de APIs REST con http y manejo de JSON (fromJson / toJson)
Manejo de estados asincrónicos: carga, éxito y error
Navegación entre pantallas pasando objetos como parámetros
Persistencia de datos local con SharedPreferences
Optimización de búsquedas con la técnica de debounce
Buenas prácticas de Git: manejo seguro de API keys con .gitignore
👤 Autor

Proyecto realizado por berserker-code como parte de mi camino de aprendizaje en desarrollo móvil con Flutter.
