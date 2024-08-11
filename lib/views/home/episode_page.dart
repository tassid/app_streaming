import 'package:flutter/material.dart';

class EpisodePage extends StatefulWidget {
  const EpisodePage({super.key});

  @override
  _EpisodePageState createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  String _selectedSeason = 'Temporada 1';
  final List<String> _seasons = [
    'Temporada 1',
    'Temporada 2',
    'Temporada 3'
  ]; // TODO: Replace with your actual seasons

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Series Title'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/fundo_banner.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.8),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Episódios',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        dropdownColor: Colors.black,
                        value: _selectedSeason,
                        items: _seasons.map((String season) {
                          return DropdownMenuItem<String>(
                            value: season,
                            child: Text(
                              season,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSeason = newValue!;
                            // TODO: Update the episode list based on the selected season
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        10, // Replace with the actual episode count for the selected season
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading:
                            const Icon(Icons.play_arrow, color: Colors.white),
                        title: Text(
                          'Episódio ${index + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Título do Episódio',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        onTap: () {
                          // TODO: Handle episode selection
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
