import 'package:flutter/material.dart';
import 'package:app_streaming/models/movie.dart';
import 'package:app_streaming/views/watch/play_page.dart';

class MovieBanner extends StatelessWidget {
  final Movie movie;

  const MovieBanner({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    // Print the genres to the console for debugging
    print('Movie: ${movie.title}');
    print('Genres: ${movie.genres.map((genre) => genre.name).toList()}');

    final genreName = movie.genres != null && movie.genres.isNotEmpty
        ? movie.genres.first.name
        : "Desconhecido";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayPage(movieId: movie.id),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(movie.getPosterUrl()),
                fit: BoxFit.cover,
                onError: (error, stackTrace) {
                  // Handle image loading error
                  print('Failed to load image: $error');
                },
              ),
            ),
          ),
          Container(
            height: 400,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 250),
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayPage(movieId: movie.id),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.play_arrow, size: 20),
                        SizedBox(width: 8),
                        Text('Assistir', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
