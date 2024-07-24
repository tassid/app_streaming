import 'package:flutter/material.dart';

Widget categoriesBar({
  required VoidCallback onCategoriesPressed,
  required BuildContext context,
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
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text('Filmes'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: onCategoriesPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text('Séries'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: onCategoriesPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text('Categorias'),
              ),
            ],
          ),
        ),
      ));
}

class FullScreenModal extends StatelessWidget {
  const FullScreenModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          children: [
            const ListTile(
              title: Text(
                'Gêneros',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const Divider(color: Colors.white),
            ListTile(
              title: const Text('Ação', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Ação quando o item for selecionado
              },
            ),
            ListTile(
              title:
                  const Text('Comédia', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Ação quando o item for selecionado
              },
            ),
            ListTile(
              title: const Text('Drama', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Ação quando o item for selecionado
              },
            ),
          ],
        );
      },
    );
  }
}
