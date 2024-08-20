import 'package:app_streaming/views/home/bars/app_bar_extra.dart';
import 'package:flutter/material.dart';
import 'package:app_streaming/services/api_service.dart';
import 'package:app_streaming/models/movie.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  late Future<List<Movie>> _myListMovies;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    // Fetch the list of movies for a specific user profile (replace with actual profile ID)
    _myListMovies =
        _fetchMyListMovies(1); // Replace 1 with the actual profile ID
  }

  Future<List<Movie>> _fetchMyListMovies(int profileId) async {
    try {
      // This would call your Flask API to fetch the movies in the user's list
      return await _apiService.fetchMoviesFromFlaskAPI(profileId);
    } catch (error) {
      print('Error fetching movies: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarExtra(title: "Minha Lista"),
      body: FutureBuilder<List<Movie>>(
        future: _myListMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No movies found.'));
          } else {
            final movies = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.black54,
                    child: GridView.builder(
                      itemCount: movies.length,
                      padding: const EdgeInsets.only(top: 20.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 2 / 3,
                      ),
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(movie.imageUrl ??
                                        'https://via.placeholder.com/150'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
