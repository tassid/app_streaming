import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:app_streaming/services/api_service.dart';
import 'package:app_streaming/models/movie.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final ApiService _apiService = ApiService();
  late Future<List<Movie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    // Fetch popular movies
    _moviesFuture = _apiService.fetchMoviesOnboarding('popular');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset('assets/netflix_logo.svg'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              launchUrlString('https://help.netflix.com/pt/node/100628');
            },
            child: const Text(
              "Política de Privacidade",
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background with images fetched from the API
          Positioned.fill(
            child: FutureBuilder<List<Movie>>(
              future: _moviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final movies = snapshot.data!;
                  return _buildMovieGrid(movies);
                } else {
                  return const Center(
                    child: Text(
                      'No movies available',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }
              },
            ),
          ),
          // Foreground content
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withOpacity(0.85),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    "Todos os seus filmes e séries em um só lugar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Assista onde quiser, quando quiser.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/login");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 18),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        "ENTRE OU INSCREVA-SE",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
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

  Widget _buildMovieGrid(List<Movie> movies) {
    final displayedMovies = movies.take(12).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: 0.7,
      ),
      itemCount: displayedMovies.length,
      itemBuilder: (context, index) {
        final movie = displayedMovies[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            movie.getPosterUrl(),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
