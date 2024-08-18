import 'package:app_streaming/views/watch/play_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_streaming/models/movie.dart';
import 'package:app_streaming/services/api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ApiService apiService = ApiService();
  List<Movie> searchResults = [];
  bool isLoading = false;
  int currentPage = 1;
  String currentQuery = '';
  bool includeAdult = false;

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        _searchMovies(currentQuery, page: currentPage + 1);
      }
    });
  }

  void _searchMovies(String query, {int page = 1}) async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Movie> movies = await apiService.searchMoviesByTitle(
        title: query,
        includeAdult: includeAdult,
        page: page,
      );

      if (movies.isEmpty) {
        if (kDebugMode) {
          print("No movies found for the query: $query");
        }
      } else {
        if (kDebugMode) {
          print("Movies found: ${movies.length}");
        }
      }

      setState(() {
        if (page == 1) {
          searchResults = movies;
        } else {
          searchResults.addAll(movies);
        }
        currentPage = page;
        isLoading = false;
        currentQuery = query;
      });
    } catch (e) {
      print("Error fetching movies: $e");
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to search movies')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search for a show, movie, etc.',
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (query) {
                  _searchMovies(
                      query); // Trigger the search when pressing enter
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                _searchMovies(_searchController
                    .text); // Trigger the search when clicking the button
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: searchResults.isEmpty && !isLoading
                  ? const Center(
                      child: Text(
                          'Nenhum resultado encontrado. Faça uma busca.',
                          style: TextStyle(color: Colors.white)))
                  : GridView.builder(
                      controller: _scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Three posters per row
                        childAspectRatio:
                            0.6, // Adjust aspect ratio for poster size
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: searchResults.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == searchResults.length) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final movie = searchResults[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlayPage(movieId: movie.id),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
