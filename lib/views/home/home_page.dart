import 'package:app_streaming/views/home/sections/build_banner_top_section.dart';
import 'package:flutter/material.dart';
import 'package:app_streaming/models/movie.dart';
import 'package:app_streaming/models/categories.dart'; // Assuming this is where your Category enum is located
import 'package:app_streaming/services/api_service.dart';
import 'package:app_streaming/views/home/bars/app_bar.dart';
import 'package:app_streaming/views/watch/play_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  late Future<List<Movie>> _popularMovies;
  late Future<List<Movie>> _topRatedMovies;
  late Future<List<Movie>> _upcomingMovies;

  // Track the selected category
  Category _selectedCategory = Category.action; // Set a default category

  @override
  void initState() {
    super.initState();
    _popularMovies = _apiService.fetchMovies('popular');
    _topRatedMovies = _apiService.fetchMovies('top_rated');
    _upcomingMovies = _apiService.fetchMovies('upcoming');
  }

  void _onCategorySelected(Category category) {
    setState(() {
      _selectedCategory = category; // Update selected category
    });
    // Fetch movies or perform other actions based on the selected category
    // Example: _apiService.fetchMoviesByCategory(category);
  }

  Widget _buildMovieCarousel(Future<List<Movie>> moviesFuture) {
    return SizedBox(
      height: 200,
      child: FutureBuilder<List<Movie>>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No movies available'));
          } else {
            final movies = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayPage(movieId: movie.id),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: 120,
                      height: 160,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(movie.getPosterUrl()),
                          fit: BoxFit.cover,
                          onError: (error, stackTrace) {
                            print('Failed to load image: $error');
                          },
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Para Você',
        selectedCategory: _selectedCategory,
        onCategorySelected: _onCategorySelected,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<Movie>>(
              future: _popularMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No movies available'));
                } else {
                  final movie = snapshot.data!.first;
                  return MovieBanner(movie: movie);
                }
              },
            ),
            _buildMovieCarousel(_topRatedMovies),
            _buildMovieCarousel(_upcomingMovies),
          ],
        ),
      ),
    );
  }
}
