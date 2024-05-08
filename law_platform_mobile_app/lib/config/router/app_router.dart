import 'package:flutter/material.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/presentation/pages/signup_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/presentation/pages/login_page.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case 'signup-page':
        return _generateRoute(const SignUpPage(), settings);

      default:
        return _generateRoute(const LoginPage(), settings);
    }
  }

  PageTransition _generateRoute(Widget page, RouteSettings settings) {
    return PageTransition(
      child: page,
      settings: settings,
      type: PageTransitionType.rightToLeft,
      duration: const Duration(milliseconds: 500),
    );
  }
}
