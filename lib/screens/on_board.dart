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
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.01),
        child: isLastPage
            ? getStartedButton()
            : buildBottomNavigationBar(width, height),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: PageView.builder(
          onPageChanged: (index) =>
              setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.9,
                  height: height * 0.4,
                  child: Lottie.network(controller.items[index].lottieUrl),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  controller.items[index].title,
                  style: TextStyle(
                    fontSize: height * 0.04,
                    color: colorTextSecondaryLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Text(
                    controller.items[index].descripcion,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 112, 112, 112),
                      fontSize: height * 0.02,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: height * 0.02),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar(double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Skip Button
        if (!isLastPage)
          TextButton(
            onPressed: () =>
                pageController.jumpToPage(controller.items.length - 1),
            child: const Text("Saltar", style: TextStyle(color: primaryColor)),
          ),
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
        // Next Button
        if (!isLastPage)
          TextButton(
            onPressed: () => pageController.nextPage(
              duration: const Duration(milliseconds: 550),
              curve: Curves.easeIn,
            ),
            child:
                const Text("Siguiente", style: TextStyle(color: primaryColor)),
          ),
      ],
    );
  }

  Widget getStartedButton() {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;

    return Container(
      width: width * 0.9,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xff0d47a1), Color(0xff0d47a1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            context.push('/login');
          },
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  "Iniciemos",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
