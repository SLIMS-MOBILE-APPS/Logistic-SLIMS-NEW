import 'package:flutter/material.dart';

import '../Screens/LogisticsHome.dart';
import '../Screens/LogisticsProfile.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const LogisticsHome(),
    const LogisticsProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Ydya App'),
        // ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08), // Adjust shadow color
                spreadRadius: 2,
                blurRadius: 8, // Adjust for softer or sharper shadow
                offset: const Offset(0, -2), // Position shadow above bottom nav
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,

            selectedItemColor:
                Color(0xFF0B66C3), // Change this to your desired color
            unselectedItemColor:
                Colors.grey, // Optional: color for unselected items
          ),
        ));
  }
}
