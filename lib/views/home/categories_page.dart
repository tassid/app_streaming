import 'package:app_streaming/models/categories.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
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
                        Navigator.of(context).pop(category);
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
                    Navigator.of(context).pop();
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

void showCategoriesPage(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Fechar',
    pageBuilder: (context, _, __) {
      return const CategoriesPage();
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: anim1,
        child: child,
      );
    },
  );
}
