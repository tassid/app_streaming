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
  late Future<List<Movie>> _categoryMovies;

  // Track the selected category
  Category _selectedCategory = Category.all; // Set a default category

  @override
  void initState() {
    super.initState();
    _fetchMoviesByCategory(_selectedCategory);
  }

  void _onCategorySelected(Category category) {
    setState(() {
      _selectedCategory = category; // Update selected category
      _fetchMoviesByCategory(
          _selectedCategory); // Fetch movies by selected category
    });
  }

  void _fetchMoviesByCategory(Category category) {
    setState(() {
      _categoryMovies = _apiService.fetchMovies(category.apiCategoryId);
    });

    _categoryMovies.then((movies) {
      if (movies.isEmpty) {
        print('No movies returned for category: ${category.categoryName}');
      } else {
        print(
            'Fetched ${movies.length} movies for category: ${category.categoryName}');
      }
    }).catchError((error) {
      print(
          'Error fetching movies for category: ${category.categoryName}, error: $error');
    });
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

  Widget _buildTopSection(Future<List<Movie>> categoryMovies) {
    return FutureBuilder<List<Movie>>(
      future: categoryMovies,
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
            _buildTopSection(_categoryMovies),
            _buildMovieCarousel(_categoryMovies),
          ],
        ),
      ),
    );
  }
}
