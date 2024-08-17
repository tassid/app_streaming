import 'package:flutter/material.dart';
import 'package:app_streaming/models/movie.dart';
import 'package:app_streaming/views/watch/play_page.dart';

class MovieBanner extends StatelessWidget {
  final Movie movie;

  const MovieBanner({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          // Background image
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
          // Dark overlay
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
          // Movie title and action buttons
          Positioned(
            bottom: 50,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
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
                        backgroundColor: Colors.red, // Netflix-like red color
                      ),
                      child: const Text('Watch Now'),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {
                        // Add more logic if needed (e.g., show movie details)
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                      ),
                      child: const Text('More Info'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
