import 'package:flutter/material.dart';
import 'package:skincare_app/features/authentication/views/home/checkpage.dart';
import 'package:skincare_app/features/authentication/views/home/home.dart';
import 'package:skincare_app/features/authentication/views/home/routinepage.dart';
import 'package:skincare_app/features/authentication/views/home/searchpage.dart';
import 'package:skincare_app/features/authentication/views/home/settingpage.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<StatefulWidget> createState() => LayoutScreenState();
}

class LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;
  List pages = const [HomePage(), CheckPage(), SearchPage(), RoutinePage(), SettingPage()];

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
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            color: Colors.black,
            blurRadius: 25,
            offset: Offset(8, 20)
            // offset: Offset(0, 7)
          )]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
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
        ),
      ),
      body: pages[_selectedIndex]
    );
  }
}
