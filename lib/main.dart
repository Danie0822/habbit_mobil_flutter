import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:habbit_mobil_flutter/routes/app_router.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Habbit',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeProvider.themeMode,
              routerConfig: router,
            );
          },
        );
      },
    );
  }
}
