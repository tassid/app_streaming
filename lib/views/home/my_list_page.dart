import 'package:app_streaming/views/home/bars/app_bar_extra.dart';
import 'package:flutter/material.dart';

class MyListPage extends StatelessWidget {
  const MyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> myListItems = [
      {'title': 'Movie 1', 'image': 'https://via.placeholder.com/150'},
      {'title': 'Movie 2', 'image': 'https://via.placeholder.com/150'},
      {'title': 'Movie 3', 'image': 'https://via.placeholder.com/150'},
      {'title': 'Movie 4', 'image': 'https://via.placeholder.com/150'},
      {'title': 'Movie 5', 'image': 'https://via.placeholder.com/150'},
    ];

    return Scaffold(
      appBar: const AppBarExtra(title: "Minha Lista"),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.black54,
              child: GridView.builder(
                itemCount: myListItems.length,
                padding: const EdgeInsets.only(top: 20.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, index) {
                  final item = myListItems[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(item['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        item['title']!,
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
      ),
    );
  }
}
