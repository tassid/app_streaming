import 'package:flutter/material.dart';

Widget categoriesBar({
  VoidCallback? onCategoriesPressed,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: GestureDetector(
      onTap: onCategoriesPressed,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ChoiceChip(
                label: const Text('Filmes'),
                selected: false,
                onSelected: (bool selected) {},
                labelStyle: const TextStyle(color: Colors.white),
                backgroundColor: Colors.transparent,
                selectedColor: Colors.grey.shade800,
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Séries'),
                selected: false,
                onSelected: (bool selected) {},
                labelStyle: const TextStyle(color: Colors.white),
                selectedColor: Colors.grey.shade800,
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/categories');
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
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
    ),
  );
}
