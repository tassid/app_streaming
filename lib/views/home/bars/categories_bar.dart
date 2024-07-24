import 'package:flutter/material.dart';

Widget categoriesBar({
  VoidCallback? onCategoriesPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: GestureDetector(
      onTap: onCategoriesPressed,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              onPressed: onCategoriesPressed,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
              ),
              child: const Text(
                'Filmes',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: onCategoriesPressed,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
              ),
              child: const Text(
                'Séries',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: onCategoriesPressed,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Categorias',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
