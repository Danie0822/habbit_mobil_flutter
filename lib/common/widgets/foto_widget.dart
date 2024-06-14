import 'package:flutter/material.dart';

List<Widget> buildFotos(List<String> urls) {
  return urls.map((url) => buildFoto(url)).toList();
}

Widget buildFoto(String url) {
  return AspectRatio(
    aspectRatio: 3 / 2,
    child: Container(
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(url),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
