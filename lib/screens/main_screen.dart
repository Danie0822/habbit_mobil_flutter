import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:habbit_mobil_flutter/common/widgets/bottom_nav_bar.dart';
import 'package:habbit_mobil_flutter/screens/request_screen.dart';
import 'package:habbit_mobil_flutter/screens/screens.dart';

// Pantalla de menú principal
class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({Key? key, required this.initialIndex}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

// Estado de la pantalla principal
class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;
  // Inicializar el controlador de página con el índice inicial
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _selectedIndex = widget.initialIndex;
  }

  // Liberar recursos
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Lista de pantallas
  final List<Widget> _screens = [
    HomeScreenOne(),
    MessagesScreen(),
    RequestsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController
          .jumpToPage(index); // Cambio rápido sin animación intermedia
    });
  }

  // Diseño de la pantalla
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _screens.map((screen) {
          return PageTransitionSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: screen,
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavBar(
        // Barra de navegación inferior
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
