import 'package:flutter/material.dart';
import 'package:skincare_app/features/check-interaction/views/checkpage.dart';
import 'package:skincare_app/features/authentication/views/home/home.dart';
import 'package:skincare_app/features/routine/views/savedroutine.dart';
import 'package:skincare_app/features/product/views/searchpage.dart';
import 'package:skincare_app/features/authentication/views/home/settingpage.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<StatefulWidget> createState() => LayoutScreenState();
}

class LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;
  List pages = const [
    HomePage(),
    CheckPage(),
    SearchPage(),
    SavedRoutinePage(),
    SettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return CupertinoTabScaffold(
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Check'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.sunny), label: 'Routine'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
      body: pages[_selectedIndex]
    );
  }
}
