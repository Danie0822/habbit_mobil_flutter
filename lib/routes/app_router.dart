import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/data/data.dart';
import 'package:habbit_mobil_flutter/data/models/confirm_password.dart';
import 'package:habbit_mobil_flutter/screens/screens.dart';
// Definición del enrutador utilizando GoRouter
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const SplashScreen(), state),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const LoginScreen(), state),
    ),
    GoRoute(
      path: '/onboard',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const OnboardingView(), state),
    ),
    GoRoute(
      path: '/forgot',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const ForgotView(), state),
    ),
    GoRoute(
      path: '/code',
      pageBuilder: (context, state) {
         final int id = state.extra as int;
        return _buildPageWithFuturisticTransition(CodeView(idUsuario: id), state);
      },
    ),
    GoRoute(
      path: '/pass',
      pageBuilder: (context, state){
        final ConfirmViewArguments args = state.extra as ConfirmViewArguments;
        return _buildPageWithFuturisticTransition(ConfirmView(arguments: args), state);
      },
    ),
    GoRoute(
      path: '/done',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const PasswordDone(), state),
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
      pageBuilder: (context, state) {
        final Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
        final int idConversacion = extra['idConversacion'];
        final String nameUser = extra['nameUser'];
        return _buildPageWithFuturisticTransition(
          ChatScreen(idConversacion: idConversacion, nameUser: nameUser),
          state,
        );
      },
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
    GoRoute(
      path: '/change',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const ChangeProfile(), state),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const SettingsScreen(), state),
    ),
  ],
   // Constructor de página de error para manejar rutas no encontradas
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(
      child: Text('Página no encontrada: ${state.uri.toString()}'),
    ),
  ),
);
// Función para construir una página con transición de desvanecimiento
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
