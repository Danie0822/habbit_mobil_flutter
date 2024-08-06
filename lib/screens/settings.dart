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
  int _currentPage = 0;
  double _textSize = 20.0;
  final CarouselController _carouselController = CarouselController();

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
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.7,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
              items: [
                Container(
                  width: double.infinity,
                  key: const ValueKey<int>(0),
                  child: _buildThemeSettingsPage(themeProvider, isDarkMode),
                ),
                Container(
                  width: double.infinity,
                  key: const ValueKey<int>(1),
                  child: _buildTextSizeSettingsPage(),
                ),
              ],
            ),
          ),
          _buildBottomSlider(),
        ],
      ),
    );
  }

  Widget _buildThemeSettingsPage(ThemeProvider themeProvider, bool isDarkMode) {
    return Column(
      key: const ValueKey<int>(0),
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
              isDarkMode ? 'assets/images/Luna.png' : 'assets/images/Sol.png',
            ),
          ),
        ),
        const SizedBox(height: 50),
        const Text(
          'Escoge un aspecto',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        const SizedBox(height: 20),
        const Text(
          'Escoge el estilo que más te guste.',
          style: TextStyle(fontWeight: FontWeight.w100, fontSize: 25),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        _buildToggleButtons(themeProvider),
      ],
    );
  }

  Widget _buildTextSizeSettingsPage() {
    return Column(
      key: const ValueKey<int>(1),
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Visibility(
          visible: _currentPage == 1,
          child: const SizedBox(height: 50),
        ),
        Visibility(
          visible: _currentPage == 1,
          child: const Text(
            'Tamaño del texto',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
        ),
        Visibility(
          visible: _currentPage == 1,
          child: const SizedBox(height: 40),
        ),
        Visibility(
          visible: _currentPage == 1,
          child: const Text(
            'Ajusta a tu preferencia el texto de la aplicación',
            style: TextStyle(fontWeight: FontWeight.w100, fontSize: 28),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 250),
        Visibility(
          visible: _currentPage == 1,
          child: Row(
            children: [
              const Text(
                'A',
                style: TextStyle(fontSize: 15),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.black,
                    inactiveTrackColor: Colors.black,
                    trackHeight: 2.0,
                    thumbColor: Colors.black,
                    overlayColor: Colors.black.withOpacity(0.2),
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 20.0),
                  ),
                  child: Slider(
                    value: _textSize,
                    min: 10,
                    max: 30,
                    divisions: 4,
                    label: _textSize.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _textSize = value;
                      });
                    },
                  ),
                ),
              ),
              const Text(
                'A',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ],
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
      borderColor: const Color.fromARGB(209, 27, 27, 27),
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
          width: 150,
          height: 100,
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

  Widget _buildBottomSlider() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(2, (index) {
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
