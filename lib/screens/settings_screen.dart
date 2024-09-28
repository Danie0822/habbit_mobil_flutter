import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Página actual
  int _currentPage = 0;
  // Controlador de CarouselSlider
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    // Cargar el tema y ajustar la página inicial según el modo de tema
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;
      setState(() {
        _currentPage = isDarkMode
            ? 0
            : 1; // 0 para la configuración de tema, 1 para la página no usada
      });
    });
  }

  // Diseño de la pantalla
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxHeight = constraints.maxHeight;
          return Column(
            children: [
              Expanded(
                // CarouselSlider para cambiar entre la configuración de tema
                child: CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: maxHeight * 0.99,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: _currentPage, // Inicializa la página actual
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                  ),
                  items: [
                    _buildThemeSettingsPage(themeProvider, isDarkMode, context),
                    // La página de tamaño de texto se ha eliminado
                  ],
                ),
              ),
              _buildBottomSlider(),
            ],
          );
        },
      ),
    );
  }

  // Página de configuración de tema
  Widget _buildThemeSettingsPage(
      ThemeProvider themeProvider, bool isDarkMode, BuildContext context) {
    // Obtener el tamaño de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth *
          0.05), // Padding dinámico basado en el ancho de la pantalla
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: SizedBox(
              key: ValueKey<bool>(isDarkMode),
              height: screenHeight *
                  0.25, // Altura dinámica basada en la altura de la pantalla
              width: screenWidth *
                  0.6, // Ancho dinámico basado en el ancho de la pantalla
              child: Image.asset(
                isDarkMode ? 'assets/images/Luna.png' : 'assets/images/Sol.png',
              ),
            ),
          ),
          const Spacer(flex: 1),
          Text(
            'Escoge un aspecto',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.08, // Tamaño de texto dinámico
            ),
          ),
          SizedBox(height: screenHeight * 0.02), // Espaciado dinámico
          Text(
            'Escoge el estilo que más te guste.',
            style: TextStyle(
              fontWeight: FontWeight.w100,
              fontSize: screenWidth * 0.06, // Tamaño de texto dinámico
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.03), // Espaciado dinámico
          _buildToggleButtons(
              themeProvider), // Este método ya debe ser responsivo
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  // Botones de alternancia para el tema claro y oscuro
  Widget _buildToggleButtons(ThemeProvider themeProvider) {
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return ToggleButtons(
      isSelected: [!isDarkMode, isDarkMode],
      onPressed: (int index) {
        setState(() {
          themeProvider.toggleTheme(index == 1);
        });
      },
      borderColor: const Color.fromARGB(209, 27, 27, 27),
      selectedBorderColor: const Color.fromARGB(255, 85, 85, 85),
      fillColor: Colors.transparent,
      selectedColor: const Color.fromARGB(255, 85, 85, 85),
      borderRadius: BorderRadius.circular(30),
      children: [
        Container(
          width: 130,
          height: 65,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: !isDarkMode
                ? const Color.fromARGB(255, 240, 240, 240)
                : const Color.fromARGB(188, 0, 0, 0),
          ),
          child: Text(
            'CLARO',
            style: TextStyle(
              fontSize: 20,
              color: !isDarkMode
                  ? const Color.fromARGB(255, 7, 7, 7)
                  : const Color.fromARGB(255, 219, 219, 219),
            ),
          ),
        ),
        Container(
          width: 130,
          height: 65,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color.fromARGB(255, 240, 240, 240)
                : const Color.fromARGB(188, 0, 0, 0),
          ),
          child: Text(
            'OSCURO',
            style: TextStyle(
              fontSize: 20,
              color: isDarkMode
                  ? const Color.fromARGB(255, 7, 7, 7)
                  : const Color.fromARGB(255, 219, 219, 219),
            ),
          ),
        ),
      ],
    );
  }

  // Indicador de página inferior para cambiar entre las páginas de configuración
  Widget _buildBottomSlider() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(1, (index) {
          // Solo 1 página ahora
          return GestureDetector(
            onTap: () {
              _carouselController.animateToPage(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _currentPage == index ? 30 : 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.black : Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        }),
      ),
    );
  }
}
