import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final Function(String) onCategorySelected;

  CategorySelector({
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Chip(label: Text(category)),
            ),
          );
        },
      ),
    );
  }
}
