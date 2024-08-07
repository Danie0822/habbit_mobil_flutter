import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/bottom_nav_bar.dart';
import 'package:habbit_mobil_flutter/screens/screens.dart';

// Pantalla principal con barra de navegación inferior y transiciones de página
class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({Key? key, required this.initialIndex}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _selectedIndex = widget.initialIndex;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Lista de pantallas mostradas en el PageView
  final List<Widget> _screens = [
    HomeScreen(),
    LikeScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  // Actualiza el índice seleccionado y anima a la página correspondiente
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: _screens.length,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * .3)).clamp(0.0, 1.0);
              }
              return Opacity(
                opacity: value,
                child: Transform(
                  transform: Matrix4.identity()
                    ..scale(value, value),
                  alignment: Alignment.center,
                  child: _screens[index],
                ),
              );
            },
            child: _screens[index],
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
