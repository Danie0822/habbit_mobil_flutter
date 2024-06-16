import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<Widget> buildPhotos(BuildContext context, List<String> urls) {
  return urls.map((url) => buildPhoto(context, url)).toList();
}

Widget buildPhoto(BuildContext context, String url) {
  return GestureDetector(
    onTap: () {
      context.push("/PhotoDetailScreen", extra: url);
    },
    child: Hero(
      tag: url,
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(url),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Ver',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
