import 'package:flutter/material.dart';

class FullscreenDialog extends StatelessWidget {
  const FullscreenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: const Text('Action'),
                  onTap: () {
                    // Handle action category selection
                  },
                ),
                ListTile(
                  title: const Text('Comedy'),
                  onTap: () {
                    // Handle comedy category selection
                  },
                ),
                ListTile(
                  title: const Text('Drama'),
                  onTap: () {
                    // Handle drama category selection
                  },
                ),
                // Add more categories here
              ],
            ),
          ],
        ),
      ),
    );
  }
}
