import 'package:app_streaming/models/categories.dart';
import 'package:app_streaming/views/home/bars/categories_bar.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Category selectedCategory;
  final void Function(Category) onCategorySelected;

  const AppBarWidget({
    super.key,
    required this.title,
    required this.selectedCategory, // Selected category passed from parent
    required this.onCategorySelected, // Callback passed from parent
  });

  @override
  Size get preferredSize => const Size.fromHeight(130);

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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
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
                categoriesBar(
                  context: context,
                  selectedCategory:
                      selectedCategory, // Pass the selected category
                  onCategorySelected:
                      onCategorySelected, // Handle category selection
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
