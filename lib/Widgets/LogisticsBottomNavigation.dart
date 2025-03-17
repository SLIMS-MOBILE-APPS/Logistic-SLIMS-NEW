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
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const LogisticsHome(),
      const LogisticsProfile(),
    ];
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      // Reload the current page by replacing it with a new instance
      setState(() {
        _pages[index] =
            index == 0 ? const LogisticsHome() : const LogisticsProfile();
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08), // Adjust shadow color
                  spreadRadius: 2,
                  blurRadius: 8, // Adjust for softer or sharper shadow
                  offset:
                      const Offset(0, -2), // Position shadow above bottom nav
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
              selectedItemColor: const Color(0xFF0B66C3),
              unselectedItemColor: Colors.grey,
            ),
          )),
    );
  }
}
