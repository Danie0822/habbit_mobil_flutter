import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/data/data.dart';
import 'package:habbit_mobil_flutter/screens/screens.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const LoginScreen(), state),
    ),
    GoRoute(
      path: '/detalle',
      pageBuilder: (context, state) {
        final propiedad = state.extra as Property;
        return _buildPageWithFuturisticTransition(
          PropertyDetailsScreen(propiedad: propiedad),
          state,
        );
      },
    ),
    GoRoute(
      path: '/PhotoDetailScreen',
      pageBuilder: (context, state) {
        final String imagen = state.extra as String;
        return _buildPageWithFuturisticTransition(
          PhotoDetailScreen(imageUrl: imagen),
          state,
        );
      },
    ),
    GoRoute(
      path: '/chat',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(ChatScreen(), state),
    ),
    GoRoute(
      path: '/main',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(MainScreen(), state),
    ),
    GoRoute(
      path: '/registar',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const RegisterScreen(), state),
    ),
    GoRoute(
      path: '/zone',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const ZoneScreen(), state),
    ),
    GoRoute(
      path: '/category',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const CategoryScreen(), state),
    ),
    GoRoute(
      path: '/price',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const PriceScreen(), state),
    ),
    GoRoute(
      path: '/ubi',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const UbiScreen(), state),
    ),
    GoRoute(
      path: '/thanks',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const ThankScreen(), state),
    ),
    GoRoute(
      path: '/editPreferences',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const EditPreferences(), state),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(
      child: Text('Página no encontrada: ${state.uri.toString()}'),
    ),
  ),
);

Page<void> _buildPageWithFuturisticTransition(
    Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
      );
      return FadeTransition(
        opacity: fadeAnimation,
        child: child,
      );
    },
  );
}
