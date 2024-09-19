import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:habbit_mobil_flutter/common/widgets/bottom_nav_bar.dart';
import 'package:habbit_mobil_flutter/screens/request_screen.dart';
import 'package:habbit_mobil_flutter/screens/screens.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  final bool reload; // Nuevo parámetro para indicar si debe recargar los widgets

  const MainScreen({Key? key, required this.initialIndex, this.reload = true}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  bool _isMenuOpen = false;
  int _currentIndex = 0;
  bool _isPageLoading = false;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _initializeScreens();
  }

  // Método para inicializar las pantallas
  void _initializeScreens() {
    _screens = [
      StartHome(onMenuStateChange: (isOpen) {
        setState(() {
          _isMenuOpen = isOpen;
        });
      }),
      MessagesScreen(),
      RequestsScreen(),
      ProfileScreen(),
    ];
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Detecta si el parámetro 'reload' ha cambiado y recarga los widgets
    if (widget.reload != oldWidget.reload) {
      debugPrint('Recargando pantallas porque reload ha cambiado.');
      _initializeScreens(); // Reinicializa las pantallas
      setState(() {
        // Fuerza la actualización del estado
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) {
    if (!_isPageLoading) {
      _pageController.jumpToPage(index);
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onPageLoading(bool isLoading) {
    setState(() {
      _isPageLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens.map((screen) {
          return PageTransitionSwitcher(
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
      ),
      bottomNavigationBar: _isMenuOpen
          ? null
          : BottomNavBar(
              currentIndex: _currentIndex,
              onTap: _navigateToPage,
            ),
    );
  }
}
