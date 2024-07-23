import 'package:app_streaming/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WhosWatchingPage extends StatefulWidget {
  const WhosWatchingPage({super.key});

  @override
  State<WhosWatchingPage> createState() => _WhosWatchingPageState();
}

class _WhosWatchingPageState extends State<WhosWatchingPage> {
  List<UserProfile> profiles = [
    UserProfile(name: 'Perfil 1'),
  ];

  void _addProfile() {
    if (profiles.length >= 5) {
      return;
    }

    setState(() {
      profiles.add(UserProfile(
        name: 'Perfil ${profiles.length + 1}',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Quem está assistindo?'),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: const Text(
              "Editar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 1,
          ),
          itemCount:
              profiles.length < 5 ? profiles.length + 1 : profiles.length,
          itemBuilder: (context, index) {
            if (index < profiles.length) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(
                    '/home',
                    arguments: profiles[index].name,
                  );
                },
                child: Column(
                  children: [
                    Card(
                      color: profiles[index].color,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const SizedBox(
                            width: 100,
                            height: 100,
                          ),
                          SvgPicture.asset(
                            'assets/icons/profile_icon.svg', // Substitua pelo caminho do seu arquivo SVG
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      profiles[index].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return GestureDetector(
                onTap: _addProfile,
                child: Column(
                  children: [
                    Card(
                      color: Colors.grey[700],
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const SizedBox(
                            width: 100,
                            height: 100,
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                          SvgPicture.asset(
                            'assets/icons/add_icon.svg', // Substitua pelo caminho do seu arquivo SVG
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Adicionar Perfil',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
