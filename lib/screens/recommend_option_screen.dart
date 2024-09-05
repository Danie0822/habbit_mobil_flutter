import 'package:flutter/material.dart';

class RecommendOptionScreen extends StatefulWidget {
  const RecommendOptionScreen({super.key});

  @override
  State<RecommendOptionScreen> createState() => RecommendOptionScreenState();
}

class RecommendOptionScreenState extends State<RecommendOptionScreen> {


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(
        child: Text("Pantalla de Recomendaciones"),
      ),
    );
  }
}
