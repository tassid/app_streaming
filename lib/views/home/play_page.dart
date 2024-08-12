import 'dart:ui';
import 'package:app_streaming/views/home/episode_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void _enterFullScreen() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

void _exitFullScreen() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
}

class PlayPage extends StatefulWidget {
  final String type; // Could be "movie" or "series"
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
  bool _isDisliked = false;
  bool _isInList = false;

  final List<String> _relatedMovies = [
    'assets/related_movie_1.jpg',
    'assets/related_movie_2.jpg',
    'assets/related_movie_3.jpg',
  ];

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

  void _toggleInList() {
    setState(() {
      _isInList = !_isInList;
    });
  }

  void _playMovie() {
    setState(() {
      _isWatchingMovie = true;
      _enterFullScreen();
      // TODO: Add your logic to play the movie
    });
  }

  void _viewTrailer() {
    _enterFullScreen();
    // TODO: Add your logic to view the trailer in fullscreen
  }

  void _viewEpisodes() {
    // TODO: Add your logic to navigate to the episodes list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fundo_banner.jpg'),
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 110),
                Center(
                  child: Image.asset(
                    'assets/poster.jpg',
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
                      _buildButton(
                        icon: Icons.play_arrow,
                        label: 'Assistir Agora',
                        backgroundColor: Colors.red,
                        onPressed: _playMovie,
                      ),
                      const SizedBox(height: 10),
                      if (widget.type == 'series') ...[
                        _buildButton(
                          icon: Icons.list,
                          label: 'Ver Episódios',
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EpisodePage()),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
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
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Recomendados para você',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    itemCount: _relatedMovies.length,
                    controller: PageController(viewportFraction: 0.6),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'image_'[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
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
