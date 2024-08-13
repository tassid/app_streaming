import 'package:app_streaming/views/home/bars/app_bar_extra.dart';
import 'package:flutter/material.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> downloadItems = [
      {'title': 'Movie 1', 'image': 'https://via.placeholder.com/150'},
      {'title': 'Movie 2', 'image': 'https://via.placeholder.com/150'},
    ];

    return Scaffold(
      appBar: const AppBarExtra(title: "Downloads"),
      body: Container(
        width: double.infinity,
        color: Colors.black54,
        child: ListView.builder(
          itemCount: downloadItems.length,
          padding: const EdgeInsets.only(top: 20.0),
          itemBuilder: (context, index) {
            final item = downloadItems[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(item['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          'Downloaded',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.0,
                          ),
                        ),
                        // Add more details or actions if needed
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
