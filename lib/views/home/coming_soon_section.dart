import 'package:flutter/material.dart';

Widget comingSoonSection() {
  return Container(
    padding: const EdgeInsets.all(8.0),
    color: Colors.blue[900],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chegando em breve...',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Confira as produções que estão chegando em breve para você.',
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          child: const Text(
            'Próximas Estreias',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    ),
  );
}
