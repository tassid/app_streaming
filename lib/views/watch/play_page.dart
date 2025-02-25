import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_streaming/services/api_service.dart';
import 'package:app_streaming/models/movie.dart';
import 'trailer_page.dart'; // Import the TrailerPage

void _enterFullScreen() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

void _exitFullScreen() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
}

class PlayPage extends StatefulWidget {
  final int movieId;

  const PlayPage({super.key, required this.movieId});

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final ApiService _apiService = ApiService();
  late Future<Movie> _movieDetailsFuture;
  late Future<List<Movie>> _relatedMoviesFuture;
  bool _isWatchingMovie = false;
  bool _isLiked = false;
  bool _isDisliked = false;
  bool _isInList = false;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _movieDetailsFuture = _apiService.fetchMovieDetails(widget.movieId);
    _relatedMoviesFuture = _apiService.fetchRelatedMovies(widget.movieId);
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) _isDisliked = false;
    });
  }

  void _toggleDislike() {
    setState(() {
      _isDisliked = !_isDisliked;
      if (_isDisliked) _isLiked = false;
    });
  }

  void _toggleInList() async {
    setState(() {
      _isInList = !_isInList;
    });

    try {
      // Assuming you have the profileId, update accordingly
      int profileId = 1; // Replace with actual profile ID
      await _apiService.addMovieToList(profileId, widget.movieId, _isInList);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(_isInList ? 'Added to list' : 'Removed from list')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update list: $error')),
      );
    }
  }

  void _playMovie() {
    setState(() {
      _isWatchingMovie = true;
      _enterFullScreen();
      // TODO: Add logic to play the movie
    });
  }

  void _viewTrailer() async {
    try {
      final trailerUrl = await _apiService.fetchTrailer(widget.movieId);
      if (trailerUrl.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrailerPage(trailerUrl: trailerUrl),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trailer não disponível.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar trailer: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
            _exitFullScreen();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder<Movie>(
        future: _movieDetailsFuture,
        builder: (context, movieSnapshot) {
          if (movieSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (movieSnapshot.hasError) {
            return Center(child: Text('Error: ${movieSnapshot.error}'));
          } else if (movieSnapshot.hasData) {
            final movie = movieSnapshot.data!;

            // Get the first genre or show "Desconhecido"
            final genreName = movie.genres.isNotEmpty
                ? movie.genres.first.name
                : "Desconhecido";

            // Extract the release year from the release date
            final releaseYear = movie.releaseDate.isNotEmpty
                ? DateTime.parse(movie.releaseDate).year.toString()
                : "Desconhecido";

            return Stack(
              children: [
                // Background with movie poster
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(movie.getPosterUrl()),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.85),
                    ),
                  ),
                ),
                // Page content
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 110),
                      Center(
                        child: Image.network(
                          movie.getPosterUrl(),
                          height: 250,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          '$releaseYear ∘ $genreName'
                          ' ∘ ${movie.getVoteAverageText().length > 5 ? movie.getVoteAverageText().substring(0, 3) : movie.getVoteAverageText()}/10',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: _buildDescription(movie.overview),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            _buildButton(
                              icon: Icons.play_arrow,
                              label: 'Assistir Agora',
                              backgroundColor: Colors.red,
                              onPressed: _playMovie,
                            ),
                            const SizedBox(height: 10),
                            _buildButton(
                              icon: Icons.play_circle_outline,
                              label: 'Ver Trailer',
                              backgroundColor: Colors.transparent,
                              borderColor: Colors.white,
                              onPressed: _viewTrailer,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildIconButton(
                                  icon: _isLiked
                                      ? Icons.thumb_up
                                      : Icons.thumb_up_off_alt,
                                  onPressed: _toggleLike,
                                ),
                                const SizedBox(width: 20),
                                _buildIconButton(
                                  icon: _isDisliked
                                      ? Icons.thumb_down
                                      : Icons.thumb_down_off_alt,
                                  onPressed: _toggleDislike,
                                ),
                                const SizedBox(width: 20),
                                _buildIconButton(
                                  icon: _isInList
                                      ? Icons.check_circle
                                      : Icons.add_circle,
                                  onPressed: _toggleInList,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      _buildRelatedMoviesCarousel(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget _buildDescription(String? description) {
    if (description == null || description.isEmpty) {
      return const Text(
        'Não há sinopse disponível para este filme.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white70,
        ),
        textAlign: TextAlign.center,
      );
    }

    const textStyle = TextStyle(
      fontSize: 16,
      color: Colors.white70,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // Create a TextPainter to calculate if the text overflows
        final textPainter = TextPainter(
          text: TextSpan(text: description, style: textStyle),
          maxLines: _isExpanded ? null : 3,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflowing = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              description,
              style: textStyle,
              maxLines: _isExpanded ? null : 4,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
            if (isOverflowing)
              TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? 'Mostrar menos' : 'Ler mais',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildRelatedMoviesCarousel() {
    return FutureBuilder<List<Movie>>(
      future: _relatedMoviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final relatedMovies = snapshot.data ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Filmes Relacionados',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300, // Adjust height to avoid overflow
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: relatedMovies.length,
                  itemBuilder: (context, index) {
                    final movie = relatedMovies[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayPage(movieId: movie.id),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                movie.getPosterUrl(),
                                height: 200, // Decrease image height
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const SizedBox(width: 100),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('No related movies available'));
        }
      },
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    Color? borderColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          side: borderColor != null
              ? BorderSide(color: borderColor, width: 1.5)
              : null,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 60,
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 30),
        onPressed: onPressed,
      ),
    );
  }
}
