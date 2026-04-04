import 'package:flutter/material.dart';
import 'package:skincare_app/features/authentication/main.dart';
import 'package:skincare_app/features/authentication/views/login/Login.dart';
import 'package:skincare_app/features/authentication/views/signin/signup.dart';
import 'package:skincare_app/features/authentication/views/splash_screen.dart';

class AppRouter {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String splash = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      // case profile:
      //   return MaterialPageRoute(builder: (_) => const ProfilePage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
