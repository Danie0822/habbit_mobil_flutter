import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark; // Modo oscuro predeterminado

  // Getter para obtener el modo de tema actual
  ThemeMode get themeMode => _themeMode;

  // Constructor
  ThemeProvider() {
    _loadThemeMode(); // Cargar el tema al iniciar
  }

  // Método para cambiar el tema
  void toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  // Método para cargar el tema
  void _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDarkMode = prefs.getBool('isDarkMode');

    // Si no hay preferencia guardada, establecer el tema en oscuro por defecto
    if (isDarkMode != null) {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark; // Tema oscuro predeterminado
    }
    
    notifyListeners(); // Notificar cambios
  }
}
