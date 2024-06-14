import 'package:flutter/material.dart';

class CustomAppBarTheme{
  CustomAppBarTheme._();
  

  static const AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.amber ,
    surfaceTintColor: Colors.blueAccent,
    iconTheme: IconThemeData(color: Colors.amber, size: 24.0),
    actionsIconTheme: IconThemeData(color: Colors.blue, size: 24.0),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color.fromARGB(0, 11, 11, 11)),
  );

  
   static const AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.amber ,
    surfaceTintColor: Colors.blueAccent,
    iconTheme: IconThemeData(color: Colors.amber, size: 24.0),
    actionsIconTheme: IconThemeData(color: Colors.blue, size: 24.0),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color.fromARGB(0, 255, 255, 255)),
  );
}