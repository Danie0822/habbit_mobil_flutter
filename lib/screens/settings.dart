import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: SizedBox(
                key: ValueKey<bool>(isDarkMode),
                height: 200.0,
                width: 250.0,
                child: Image.asset(
                  isDarkMode
                      ? 'assets/images/Luna.png'
                      : 'assets/images/Sol.png',
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Escoge un aspecto',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(height: 10),
            const Text(
              'Escoge el estilo que más te guste.',
              style: TextStyle(fontWeight: FontWeight.w100, fontSize: 25),
            ),
            const SizedBox(height: 20),
            _buildToggleButtons(themeProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButtons(ThemeProvider themeProvider) {
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return ToggleButtons(
      isSelected: [!isDarkMode, isDarkMode],
      onPressed: (int index) {
        setState(() {
          themeProvider.toggleTheme(index == 1);
        });
      },
      borderColor: Color.fromARGB(209, 27, 27, 27),
      selectedBorderColor: const Color.fromARGB(255, 85, 85, 85),
      fillColor: Colors.transparent,
      selectedColor: const Color.fromARGB(255, 85, 85, 85),
      borderRadius: BorderRadius.circular(30),
      children: [
        Container(
          width: 150,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: !isDarkMode ? Color.fromARGB(255, 240, 240, 240): const Color.fromARGB(188, 0, 0, 0),

          ),
          child: Text(
            'CLARO',
            style: TextStyle(
              fontSize: 20,
              color: !isDarkMode ? const Color.fromARGB(255, 7, 7, 7) : const Color.fromARGB(255, 219, 219, 219),
            ),
          ),
        ),
        Container(
          width: 150,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isDarkMode ? Color.fromARGB(255, 240, 240, 240) : const Color.fromARGB(188, 0, 0, 0),

          ),
          child: Text(
            'OSCURO',
            style: TextStyle(
              fontSize: 20,
              color: isDarkMode ? const Color.fromARGB(255, 7, 7, 7) : const Color.fromARGB(255, 219, 219, 219),
            ),
          ),
        ),
      ],
    );
  }
}
