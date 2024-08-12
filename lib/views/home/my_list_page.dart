import 'package:flutter/material.dart';

class MyListPage extends StatelessWidget {
  const MyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black54,
        ),
        child: const Center(
          child: Text('This is the My List page.'),
        ),
      ),
    );
  }
}
