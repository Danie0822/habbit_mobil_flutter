import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/bottom_nav_bar.dart';
import 'package:habbit_mobil_flutter/screens/home_page.dart';
import 'package:habbit_mobil_flutter/screens/like_screen.dart';
import 'package:habbit_mobil_flutter/screens/messages_screen.dart';
import 'package:habbit_mobil_flutter/screens/profile_screen.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    LikeScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}