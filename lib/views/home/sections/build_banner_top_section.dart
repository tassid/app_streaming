import 'package:app_streaming/views/watch/play_page.dart';
import 'package:flutter/material.dart';

class BannerTopSection extends StatefulWidget {
  @override
  _BannerTopSectionState createState() => _BannerTopSectionState();
}

class _BannerTopSectionState extends State<BannerTopSection> {
  bool isAddedToList = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 450,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
                child: Image.asset(
                  'assets/fundo_banner.jpg',
                  width: double.infinity,
                  height: 500,
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                child: Container(
                  padding: const EdgeInsets.all(40.0),
                  color: Colors.grey[900]?.withOpacity(0.6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Text(
                        'Movie Title',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Genre 1 • Genre 2 • Genre 2',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const PlayPage(
                                      type: 'series',
                                      title: 'Title',
                                      description: 'Lorem ipsum',
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                minimumSize: const Size(0, 48),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 24,
                              ),
                              label: const Text(
                                'Assistir',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  isAddedToList = !isAddedToList;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isAddedToList
                                    ? Colors.grey[600]
                                    : Colors.grey[800],
                                minimumSize: const Size(0, 48),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              icon: Icon(
                                isAddedToList ? Icons.check : Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                              label: Text(
                                isAddedToList ? 'Adicionado' : 'Minha Lista',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
