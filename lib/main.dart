import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme.dart';
import 'package:habbit_mobil_flutter/routes/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}