import 'package:app_streaming/models/categories.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class CategoriesPage extends StatelessWidget {
  final void Function(Category)
      onCategorySelected; // Update the type to Category

  const CategoriesPage({
    super.key,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  children: Category.values.map((category) {
                    return ListTile(
                      title: Text(
                        category.categoryName,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(); // Close the dialog
                        onCategorySelected(category); // Trigger the callback
                      },
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Close the dialog without selecting
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
