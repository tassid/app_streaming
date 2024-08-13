import 'package:app_streaming/views/home/bars/app_bar_extra.dart';
import 'package:app_streaming/views/home/profile_edit_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  get profile => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarExtra(title: 'Settings'),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black54,
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text('Conta', style: TextStyle(color: Colors.white)),
              onTap: () {
                EditProfilePage(profile: profile);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.white),
              title: const Text('Notifications',
                  style: TextStyle(color: Colors.white)),
              trailing: Switch(
                value: true,
                onChanged: (bool value) {},
                activeColor: Colors.blue,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.white),
              title:
                  const Text('Privacy', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help, color: Colors.white),
              title: const Text('Help & Support',
                  style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
