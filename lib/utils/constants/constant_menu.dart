import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/screens/home_screen.dart';
import 'package:habbit_mobil_flutter/screens/like_screen.dart';
import 'package:rive/rive.dart';
import 'package:habbit_mobil_flutter/screens/home_page.dart';

// Clase que representa un ítem del menú con animaciones Rive
class RiveAsset {
  final String artboard, stateMachineName, title, src;
  SMIBool? input; // Inicialización opcional
  final Widget screen;

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      required this.screen,
      this.input});

  // Setter para modificar el valor de input
  set setInput(SMIBool status) {
    input = status;
  }
}

// Lista global del menú lateral
List<RiveAsset> sideMenu = [
  RiveAsset(
    'assets/rive/icons.riv',
    artboard: 'HOME',
    stateMachineName: 'HOME_interactivity',
    title: 'Inicio',
    screen: HomeScreenOne(),
  ),
  RiveAsset(
    'assets/rive/icons.riv',
    artboard: 'SEARCH',
    stateMachineName: 'SEARCH_Interactivity',
    title: 'Búsquedas',
    screen: HomeScreen(),
  ),
  RiveAsset(
    'assets/rive/icons.riv',
    artboard: 'LIKE/STAR',
    stateMachineName: 'STAR_Interactivity',
    title: 'Likes',
    screen: LikeScreen(),
  )

];
