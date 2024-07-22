import 'package:flutter/material.dart';
import 'dart:math';

class WhosWatchingPage extends StatefulWidget {
  @override
  _WhosWatchingPageState createState() => _WhosWatchingPageState();
}

class _WhosWatchingPageState extends State<WhosWatchingPage> {
  // Modifique a lista de profiles para armazenar mapas com nome e cor
  List<Map<String, dynamic>> profiles = [
    {'name': 'Perfil 1', 'color': Colors.blue},
    // Adicione mais perfis aqui se necessário
  ];

  void _addProfile() {
    final Random random = Random();
    // Gera uma cor aleatória
    Color randomColor =
        Colors.primaries[random.nextInt(Colors.primaries.length)];
    setState(() {
      profiles.add({
        'name': 'Perfil ${profiles.length + 1}',
        'color': randomColor,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Restante do código Scaffold...
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: profiles.length + 1, // Adiciona espaço para o botão "+"
          itemBuilder: (context, index) {
            if (index < profiles.length) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/home', arguments: profiles[index]['name']);
                },
                child: Card(
                  color: profiles[index]
                      ['color'], // Aplica a cor do perfil ao Card
                  child: Center(
                    child: Text(
                      profiles[index]['name'], // Usa o nome do perfil
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            } else {
              // Botão "+" para adicionar novos perfis
              return GestureDetector(
                onTap: _addProfile,
                child: Card(
                  color: Colors.grey[700],
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
