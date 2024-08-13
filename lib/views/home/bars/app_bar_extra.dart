import 'package:flutter/material.dart';
import 'dart:ui';

class AppBarExtra extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarExtra({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 100,
              sigmaY: 100,
            ),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        SafeArea(
          child: Material(
            type: MaterialType.transparency,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.cast, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.account_circle,
                            color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppBarPage extends StatelessWidget {
  const AppBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarExtra(title: 'My Streaming App'),
      body: Container(
        color: Colors.black54,
        child: const Center(
          child: Text(
            'Content goes here',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
