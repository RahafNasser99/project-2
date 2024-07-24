import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:law_platform_mobile_app/utils/global_classes/configurations.dart';
import 'package:law_platform_mobile_app/config/theme/app_theme.dart';
import 'package:law_platform_mobile_app/config/router/app_router.dart';
import 'package:law_platform_mobile_app/utils/global_classes/check_authentication.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  prefs = await SharedPreferences.getInstance();

  final CheckAuthentication checkAuthentication = CheckAuthentication();

  final bool isAuthenticated = checkAuthentication.isAuthenticated();

  runApp(MyApp(
    isAuthenticated: isAuthenticated,
  ));
}

class MyApp extends StatelessWidget {
  final bool isAuthenticated;
  const MyApp({
    super.key,
    required this.isAuthenticated,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Law Platform',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightTheme, 
      initialRoute: isAuthenticated ? 'home-page' : 'signup-page',
      // initialRoute:  'profile-page',
      onGenerateRoute: (settings) => AppRouter().onGenerateRoute(settings),
    );
  }
}
