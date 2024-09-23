import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SliderCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final int currentIndex;
  final int itemCount;
  final String buttonText;
  final Color startColor;
  final Color endColor;
  final String navegation;

  const SliderCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.currentIndex,
    required this.itemCount,
    required this.buttonText,
    required this.startColor,
    required this.endColor,
    required this.navegation,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        double cardPadding = screenWidth * 0.04;
        double cardHeight = screenWidth < 600 ? screenHeight * 0.35 : screenHeight * 0.4;
        double imageSize = screenWidth * 0.2;
        double titleFontSize = screenWidth * 0.06;
        double descriptionFontSize = screenWidth * 0.025;
        double buttonFontSize = screenWidth * 0.035;

        return Container(
          padding: EdgeInsets.all(cardPadding),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          height: cardHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [startColor, endColor],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: titleFontSize,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: Colors.white,
                                  fontSize: descriptionFontSize,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.push(navegation, extra: 1);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05,
                                vertical: screenHeight * 0.03,
                              ),
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xff0d47a1),
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: FittedBox(
                              child: Text(
                                buttonText,
                                style: TextStyle(fontSize: buttonFontSize),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        imagePath,
                        height: imageSize,
                        width: imageSize,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  itemCount,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: currentIndex == index ? 12.0 : 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
