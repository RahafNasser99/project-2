import 'package:flutter/material.dart';
import 'package:law_platform_mobile_app/config/theme/app_theme.dart';
import 'package:law_platform_mobile_app/config/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Law Platform',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightTheme,
      initialRoute: 'signup-page',
      onGenerateRoute: (settings) => AppRouter().onGenerateRoute(settings),
    );
  }
}
