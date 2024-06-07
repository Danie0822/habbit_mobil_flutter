import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/routes/app_routes.dart';
import 'package:habbit_mobil_flutter/screens/screens.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return _materialPageRoute(HomeScreen());
      case AppRoutes.like:
        return _materialPageRoute(LikeScreen());
      case AppRoutes.login:
        return _materialPageRoute(const LoginScreen());
      case AppRoutes.messages:
        return _materialPageRoute(MessagesScreen());
      case AppRoutes.profile:
        return _materialPageRoute(ProfileScreen());
      case AppRoutes.mainScreen:
        return MaterialPageRoute(builder: (_) => MainScreen());
      default:
        return _materialPageRoute(MainScreen());
    }
  }

  static MaterialPageRoute _materialPageRoute(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }
}
