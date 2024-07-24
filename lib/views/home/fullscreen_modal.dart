import 'package:flutter/material.dart';

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
              onTap: () {},
            ),
            ListTile(
              title:
                  const Text('Comédia', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Drama', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}
