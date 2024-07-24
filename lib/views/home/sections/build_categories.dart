import 'package:flutter/material.dart';

// Define um tipo para o callback que atualiza a categoria selecionada
typedef OnCategorySelected = void Function(String category);

Widget buildCategories({
  required List<String> categories,
  required String selectedCategory,
  required OnCategorySelected onCategorySelected,
}) {
  return Container(
    height: 40,
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ChoiceChip(
            label: Text(category),
            selected: selectedCategory == category,
            onSelected: (bool selected) {
              onCategorySelected(category);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
    ),
  );
}
