// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/search_input.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class HeaderScreen extends StatelessWidget {
  final bool isSearchVisible;
  final VoidCallback onSearchToggle;
  final Animation<Offset> offsetAnimation;
  final Function(String) onSearchChanged;
  final String hintTextt;

  const HeaderScreen({
    Key? key,
    required this.isSearchVisible,
    required this.onSearchToggle,
    required this.offsetAnimation,
    required this.onSearchChanged,
    required this.hintTextt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Mensajes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: whiteColor,
                ),
              ),
              IconButton(
                onPressed: onSearchToggle,
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: child.key == const ValueKey('search') ? animation : Tween<double>(begin: 1, end: 0.75).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: Icon(
                    isSearchVisible ? Icons.close : Icons.search,
                    key: ValueKey(isSearchVisible ? 'close' : 'search'),
                    color: whiteColor,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
          if (isSearchVisible)
            SlideTransition(
              position: offsetAnimation,
              child: SearchInput(
                onChanged: onSearchChanged,
                hintText: hintTextt,
              ),
            ),
        ],
      ),
    );
  }
}
