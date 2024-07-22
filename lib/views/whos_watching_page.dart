import 'package:flutter/material.dart';
import 'dart:math';

class WhosWatchingPage extends StatefulWidget {
  const WhosWatchingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WhosWatchingPageState createState() => _WhosWatchingPageState();
}

class _WhosWatchingPageState extends State<WhosWatchingPage> {
  List<Map<String, dynamic>> profiles = [
    {'name': 'Perfil 1', 'color': Colors.red},
  ];

  double _calculateLuminance(Color color) {
    final r = color.red / 255;
    final g = color.green / 255;
    final b = color.blue / 255;

    final rLuminance =
        (r <= 0.03928) ? r / 12.92 : pow((r + 0.055) / 1.055, 2.4);
    final gLuminance =
        (g <= 0.03928) ? g / 12.92 : pow((g + 0.055) / 1.055, 2.4);
    final bLuminance =
        (b <= 0.03928) ? b / 12.92 : pow((b + 0.055) / 1.055, 2.4);

    return 0.2126 * rLuminance + 0.7152 * gLuminance + 0.0722 * bLuminance;
  }

  double _calculateContrast(Color color1, Color color2) {
    final luminance1 = _calculateLuminance(color1);
    final luminance2 = _calculateLuminance(color2);

    final light = max(luminance1, luminance2);
    final dark = min(luminance1, luminance2);

    return (light + 0.05) / (dark + 0.05);
  }

  bool _isColorContrastingWithWhite(Color color) {
    return _calculateContrast(color, Colors.white) >= 4.5;
  }

  void _addProfile() {
    if (profiles.length >= 5) {
      return;
    }

    final Random random = Random();
    Color randomColor = Colors.blue;
    bool isColorUnique = false;

    while (!isColorUnique) {
      randomColor = Colors.primaries[random.nextInt(Colors.primaries.length)];

      isColorUnique =
          !profiles.any((profile) => profile['color'] == randomColor) &&
              _isColorContrastingWithWhite(randomColor);
    }

    setState(() {
      profiles.add({
        'name': 'Perfil ${profiles.length + 1}',
        'color': randomColor,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Quem está assistindo?'),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: const Text(
              "Editar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 1,
          ),
          itemCount:
              profiles.length < 5 ? profiles.length + 1 : profiles.length,
          itemBuilder: (context, index) {
            if (index < profiles.length) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(
                    '/home',
                    arguments: profiles[index]['name'],
                  );
                },
                child: Column(
                  children: [
                    Card(
                      color: profiles[index]['color'],
                      child: const SizedBox(
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      profiles[index]['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return GestureDetector(
                onTap: _addProfile,
                child: Column(
                  children: [
                    Card(
                      color: Colors.grey[700],
                      child: const SizedBox(
                        width: 100,
                        height: 100,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Adicionar Perfil',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProfile,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
