import 'package:anime_flutter/ui/views/anime_list_view.dart';
import 'package:flutter/material.dart';

import 'views/home_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    const views = [
      HomeView(),
      AnimeListView(),
    ];
    return Scaffold(
      body: views[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.list_rounded), label: "List"),
        ],
      ),
    );
  }
}
