import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/data/services/onboarding_items.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart'; 

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => OnboardingViewState();
}

class OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();


  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage ? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Skip Button
            TextButton(
              onPressed: () => pageController.jumpToPage(controller.items.length - 1),
              child: const Text("Saltar", style: TextStyle(color:primaryColor )),
            ),
            const SizedBox(width: 20,),
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              onDotClicked: (index) => pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeIn,
              ),
              effect: const WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: primaryColor,
              ),
            ),
            const SizedBox(),
            // Next Button
            TextButton(
              onPressed: () => pageController.nextPage(
                duration: const Duration(milliseconds: 550),
                curve: Curves.easeIn,
              ),
              child: const Text("Siguiente", style: TextStyle(color: primaryColor)),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) => setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 600, // Set your desired width here
                  height: 300, // Set your desired height here
                  child: Lottie.network(controller.items[index].lottieUrl),
                ),
                const SizedBox(height: 15),
                Text(
                  controller.items[index].title,
                  style: const TextStyle(fontSize: 30, color: colorTextSecondaryLight,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0), // Ajusta el padding según sea necesario
                  child: Text(
                    controller.items[index].descripcion,
                    style: const TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 15),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent, // Hacemos transparente el fondo del contenedor
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          context.push('/login');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Color de fondo
          foregroundColor: Colors.white, // Color del texto
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Relleno
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Bordes redondeados
          ),
          elevation: 5, // Sombra
        ),
        child: const Text(
          "Iniciemos",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
