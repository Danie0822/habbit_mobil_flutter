import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors_menu.dart';

// Widget BottomNavBar
class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final iconList = <IconData>[
    Icons.home,
    Icons.favorite,
    Icons.message,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: widget.currentIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: widget.onTap,
        backgroundColor: backgroundColor,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        splashColor: splashColor,
        iconSize: 28,
        height: 70,
      ),
    );
  }
}
