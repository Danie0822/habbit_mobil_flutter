import 'package:flutter/cupertino.dart';
import 'package:habbit_mobil_flutter/screens/home_page.dart';
// Clase que representa un ítem del menú con animaciones Rive
class MenuModel {
  // Atributos de la clase
  Widget _currentScreen = HomeScreen();
  bool _isInputActive = false;

  // getter y setter para la pantalla actual
  Widget get currentScreen => _currentScreen;
  set currentScreen(Widget screen) {
    _currentScreen = screen;
  }

  // getter y setter para el estado de la entrada
  bool get isInputActive => _isInputActive;
  set isInputActive(bool isActive) {
    _isInputActive = isActive;
  }

  // Método para actualizar la pantalla
  void updateScreen(Widget newScreen) {
    _currentScreen = newScreen;
  }

  // Método para actualizar el estado de la entrada
  void updateInputState(bool isActive) {
    _isInputActive = isActive;
  }
}
