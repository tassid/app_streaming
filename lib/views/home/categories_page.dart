import 'package:flutter/material.dart';
import 'dart:ui';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  children: [
                    const ListTile(
                      title: Text(
                        'Categorias',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(color: Colors.white),
                    ListTile(
                      title: const Text('Ação',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Aventura',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Clássicos',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Comédia',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Crime',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Drama',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Família',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close, color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showCategoriesPage(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    pageBuilder: (context, _, __) {
      return const CategoriesPage();
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: anim1,
        child: child,
      );
    },
  );
}
