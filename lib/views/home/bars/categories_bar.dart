import 'package:app_streaming/models/categories.dart';
import 'package:app_streaming/views/home/categories_page.dart';
import 'package:flutter/material.dart';

Widget categoriesBar({
  required BuildContext context,
  required Category selectedCategory,
  required void Function(Category) onCategorySelected,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              onPressed: () {
                _showCategoriesDialog(context, onCategorySelected);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedCategory.categoryName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Icon(
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

void _showCategoriesDialog(
    BuildContext context, void Function(Category) onCategorySelected) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CategoriesPage(
        onCategorySelected: onCategorySelected,
      );
    },
  );
}
