import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/screens/login.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system, 
      home: const Login(),
    );
  }
}
