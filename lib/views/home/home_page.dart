import 'package:app_streaming/views/home/downloads_page.dart';
import 'package:app_streaming/views/home/my_list_page.dart';
import 'package:app_streaming/views/home/sections/build_banner_top_section.dart';
import 'package:app_streaming/views/home/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:app_streaming/views/home/bars/app_bar.dart';
import 'package:app_streaming/views/home/sections/build_section.dart';
import 'package:app_streaming/views/home/sections/coming_soon_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.add(
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 210),
            BannerTopSection(),
            const BuildSection(title: 'Recomendados para você'),
            comingSoonSection(),
          ],
        ),
      ),
    );
    _pages.add(const MyListPage());
    _pages.add(const DownloadsPage());
    _pages.add(const SettingsPage());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isFirstPage = _selectedIndex == 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: isFirstPage ? const AppBarWidget(title: 'Para Você') : null,
      body: Column(
        children: [
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Baixados',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}
