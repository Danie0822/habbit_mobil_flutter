// ignore_for_file: unnecessary_brace_in_string_interps, deprecated_member_use, unnecessary_string_interpolations

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
class SectionCardWithImage extends StatelessWidget {
  final String title;
  final String description;
  final LinearGradient backgroundGradient;
  final String buttonText;
  final String imagePath;
  final String navegation;


  const SectionCardWithImage({
    super.key,
    required this.title,
    required this.description,
    required this.backgroundGradient,
    required this.buttonText,
    required this.imagePath,
    required this.navegation,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: backgroundGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.white,
                        fontSize: 30, 
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Colors.white70,
                        fontSize: 12, 
                      ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.push('${navegation}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                  ),
                  child: Text(buttonText),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Image.asset(
            'assets/images/${imagePath}',
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
