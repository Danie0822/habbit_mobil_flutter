import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/floating_navbar.dart';

class RecommendOptionScreen extends StatefulWidget {
  const RecommendOptionScreen({super.key});

  @override
  State<RecommendOptionScreen> createState() => RecommendOptionScreenState();
}

class RecommendOptionScreenState extends State<RecommendOptionScreen> {
  int _currentIndex = 1; // Aquí el índice de la pestaña de Recomendado

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      context.go('/map_screen');
    } else if (index == 1) {
      context.go('/recommend_option');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Pantalla de Recomendaciones"),
      ),
      // Agregamos la barra de navegación flotante
      floatingActionButton: FloatingNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
