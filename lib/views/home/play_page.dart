import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:app_streaming/views/home/episode_page.dart';

class PlayPage extends StatefulWidget {
  final String type;
  final String title;
  final String description;

  const PlayPage({
    super.key,
    required this.type,
    required this.title,
    required this.description,
  });

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  bool _isWatchingMovie = false;
  bool _isLiked = false;
  bool _isInList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('assets/fundo_banner.jpg'), // Background image
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/poster.jpg', // Poster image
                  height: 250,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Assistir Agora'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            onPressed: () {
                              setState(() {
                                _isWatchingMovie = true;
                                // TODO: Add your logic to play the movie
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.play_circle_outline),
                            label: const Text('Ver Trailer'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.transparent,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              side: const BorderSide(
                                  color: Colors.white, width: 1.5),
                            ),
                            onPressed: () {
                              // TODO: Add your logic to view the trailer in fullscreen
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: widget.type == 'series' && !_isWatchingMovie
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EpisodePage(),
                  ),
                );
              },
              backgroundColor: Colors.red,
              icon: const Icon(Icons.playlist_play),
              label: const Text('Episódios'),
            )
          : null,
    );
  }
}
