import 'package:flutter/material.dart';

class TvShowsPage extends StatelessWidget {
  const TvShowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Séries',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSection('Ação', <Widget>[
                  // Add action movie widgets here
                ]),
                buildSection('Comédia', <Widget>[
                  // Add comedy movie widgets here
                ]),
                buildSection('Drama', <Widget>[
                  // Add drama movie widgets here
                ]),
                // Add more sections for different genres
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSection(String title, List<Widget> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: movies,
          ),
        ),
      ],
    );
  }
}
