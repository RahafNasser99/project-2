import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/presentation/pages/comments_page.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/presentation/cubits/signup_cubits/cubit/signup_cubit.dart';
import 'package:law_platform_mobile_app/features/profile/presentation/pages/profile_page.dart';
import 'package:law_platform_mobile_app/features/search/presentation/pages/search_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:law_platform_mobile_app/home_page.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/presentation/pages/add_post_page.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/presentation/pages/login_page.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/presentation/pages/signup_page.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/presentation/cubits/login_cubits/cubit/login_cubit.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginPage(),
          ),
        );

      case 'signup-page':
        return _generateRoute(
            BlocProvider(
              create: (context) => SignupCubit(),
              child: const SignUpPage(),
            ),
            settings,
            PageTransitionType.rightToLeft);

      case 'home-page':
        return _generateRoute(
            const HomePage(), settings, PageTransitionType.rightToLeft);

      case 'add-post-page':
        return _generateRoute(
            const AddPostPage(), settings, PageTransitionType.bottomToTop);

      case 'comments-page':
        return _generateRoute(
            const CommentsPage(), settings, PageTransitionType.bottomToTop);

      case 'search-page':
        return MaterialPageRoute(
          builder: (context) => const SearchPage(),
        );

      case 'profile-page':
        return _generateRoute(
            const ProfilePage(), settings, PageTransitionType.rightToLeft);

      default:
        return _generateRoute(
            const LoginPage(), settings, PageTransitionType.rightToLeft);
    }
  }

  PageTransition _generateRoute(Widget page, RouteSettings settings,
      PageTransitionType pageTransitionType) {
    return PageTransition(
      child: page,
      settings: settings,
      type: pageTransitionType,
      duration: const Duration(milliseconds: 500),
    );
  }
}
