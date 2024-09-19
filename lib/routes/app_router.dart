import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/data/models/blogs_main.dart';
import 'package:habbit_mobil_flutter/data/models/request_model.dart';
import 'package:habbit_mobil_flutter/screens/screens.dart';
import 'package:habbit_mobil_flutter/screens/update_request.dart';
import 'package:habbit_mobil_flutter/data/models/slider.dart';

// Definición del enrutador utilizando GoRouter
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const SplashScreen(), state),
    ),
    GoRoute(
      path: '/about',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const AboutCompany(), state),
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
        return _buildPageWithFuturisticTransition(
            CodeView(idUsuario: id), state);
      },
    ),
    GoRoute(
      path: '/pass',
      pageBuilder: (context, state) {
        final ConfirmViewArguments args = state.extra as ConfirmViewArguments;
        return _buildPageWithFuturisticTransition(
            ConfirmView(arguments: args), state);
      },
    ),
    GoRoute(
      path: '/done',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const PasswordDone(), state),
    ),
    GoRoute(
        path: '/newRequest',
        pageBuilder: (context, state) =>
            _buildPageWithFuturisticTransition(const NewRequest(), state)),
    GoRoute(
      path: '/detalle',
      pageBuilder: (context, state) {
        final Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
        final int idPropiedad = extra['id_propiedad'];
        return _buildPageWithFuturisticTransition(
          PropertyDetailsScreen(idPropiedad: idPropiedad),
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
      path: '/message',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const MessagesScreen(), state),
    ),
    GoRoute(
      path: '/main',
      pageBuilder: (context, state) {
        final int initialIndex = state.extra as int;
        return _buildPageWithFuturisticTransition(
            MainScreen(initialIndex: initialIndex, reload: true), state);
      },
    ),
    GoRoute(
      path: '/updateRequest',
      pageBuilder: (context, state) {
        final RequestModel request = state.extra as RequestModel;
        return _buildPageWithFuturisticTransition(
            UpdateRequest(request: request), state);
      },
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
    GoRoute(
      path: '/thanks_register',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const ThanksRegister(), state),
    ),
    GoRoute(
      path: '/likes',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(LikeScreen(), state),
    ),
    GoRoute(
      path: '/zone_update',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const ZoneScreenUp(), state),
    ),
    GoRoute(
      path: '/map_screen',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const MapScreen(), state),
    ),
    GoRoute(
      path: '/recommend_option',
      pageBuilder: (context, state) => _buildPageWithFuturisticTransition(
          const RecommendOptionScreen(), state),
    ),
    GoRoute(
      path: '/slider',
      pageBuilder: (context, state) {
        final List<SliderResponse> cards = state.extra as List<SliderResponse>;
        return MaterialPage(
          child:
              SliderScreen(cards: cards), // Pasamos las tarjetas a la pantalla
        );
      },
    ),
    GoRoute(
      path: '/home_screen',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const HomeScreenOne(), state),
    ),
    GoRoute(
      path: '/calendar',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const VisitScreen(), state),
    ),
    GoRoute(
      path: '/categoryUpdate',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const CategoryScreenUp(), state),
    ),
    GoRoute(
      path: '/PriceScreenUp',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const PriceScreenUp(), state),
    ),
    GoRoute(
      path: '/UbiScreenUp',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const UbiScreenUp(), state),
    ),
    GoRoute(
      path: '/detailBlogs',
      pageBuilder: (context, state) {
        final BlogsResponse blogsData = state.extra as BlogsResponse;
        return _buildPageWithFuturisticTransition(
            BlogDetail(blogsResponse: blogsData), state);
      },
    ),
    GoRoute(
      path: '/blogMain',
      pageBuilder: (context, state) =>
          _buildPageWithFuturisticTransition(const blogMain(), state),
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
