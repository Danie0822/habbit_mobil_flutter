import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:habbit_mobil_flutter/common/widgets/bottom_nav_bar.dart';
import 'package:habbit_mobil_flutter/screens/request_screen.dart';
import 'package:habbit_mobil_flutter/screens/screens.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({Key? key, required this.initialIndex}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  bool _isMenuOpen = false; // Variable para controlar la visibilidad del menú
  int _currentIndex = 0; // Variable para almacenar el índice actual

  // Lista de pantallas con callback para actualizar el estado del menú
  late List<Widget> _screens;

  // Inicializa el controlador de la página y la lista de pantallas
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Inicializa el índice actual
    _pageController = PageController(initialPage: widget.initialIndex);
    _screens = [
      // Inicializa las pantallas con el callback para actualizar el estado del menú
      StartHome(onMenuStateChange: (isOpen) {
        setState(() {
          _isMenuOpen = isOpen;
        });
      }),
      const MessagesScreen(),
      const RequestsScreen(),
      const ProfileScreen(),
    ];
  }

  // Libera los recursos del controlador de la página
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Método para navegar entre páginas, solo si el menú está cerrado
  void _navigateToPage(int index) {
    if (!_isMenuOpen) { // Solo navega si el menú está cerrado
      _pageController.jumpToPage(index);
      setState(() {
        _currentIndex = index; // Actualiza el índice actual
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPageView(
        controller: _pageController,
        onPageChanged: (index) {
          if (!_isMenuOpen) { // Permite el cambio de página solo si el menú está cerrado
            setState(() {
              _currentIndex = index; // Actualiza el índice actual
            });
          }
        },
        isMenuOpen: _isMenuOpen,
        screens: _screens,
      ),
      bottomNavigationBar: _isMenuOpen
          ? null // Oculta la barra de navegación cuando el menú está abierto
          : BottomNavBar(
              currentIndex: _currentIndex, // Usa la variable de índice actual
              onTap: _navigateToPage,
            ),
    );
  }
}
// Custom PageView para controlar la animación de transición de página
class CustomPageView extends StatelessWidget {
  final PageController controller;
  final ValueChanged<int> onPageChanged;
  final bool isMenuOpen;
  final List<Widget> screens;

  const CustomPageView({
    Key? key,
    required this.controller,
    required this.onPageChanged,
    required this.isMenuOpen,
    required this.screens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: onPageChanged,
      physics: isMenuOpen ? const NeverScrollableScrollPhysics() : null, // Deshabilita el desplazamiento si el menú está abierto
      children: screens.map((screen) {
        return isMenuOpen
            ? screen // Muestra la pantalla directamente sin animación
            : PageTransitionSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation, Animation<double> secondaryAnimation) {
                  return FadeThroughTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  );
                },
                child: screen,
              );
      }).toList(),
    );
  }
}
