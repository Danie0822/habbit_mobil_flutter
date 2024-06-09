import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/screens/screens.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => MainScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: Text('Error')),
    body: Center(
      child: Text('Página no encontrada: ${state.location}'),
    ),
  ),
);