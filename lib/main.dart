import 'package:flutter/material.dart';
import 'package:med_pilot_ai/core/responsive/screen_util.dart';
import 'package:med_pilot_ai/core/router/app_router.dart';
import 'package:med_pilot_ai/core/theme/app_theme.dart';
import 'package:med_pilot_ai/presentation/splash_screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreenUtil.init(
      child: const SplashScreen(),
      builder: (context, child) {
        return MaterialApp.router(
          title: 'MedPilot AI',
          debugShowCheckedModeBanner: false,

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,

          routerConfig: AppRouter.router,
        );
      },
    );
  }
}