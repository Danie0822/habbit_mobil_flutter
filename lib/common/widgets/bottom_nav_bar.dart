import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors_menu.dart';

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

  final labelList = <String>[
    'Home',
    'Favorite',
    'Message',
    'User',
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
      child: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? activeColor : inactiveColor;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 28,
                color: color,
              ),
              if (isActive) // Show text only if the tab is active
                Text(
                  labelList[index],
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                  ),
                ),
            ],
          );
        },
        activeIndex: widget.currentIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: widget.onTap,
        backgroundColor: backgroundColor,
        splashColor: splashColor,
        height: 70,
      ),
    );
  }
}
