import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_webschool_sec/views/home/home_view.dart';

import '../views/login/login_view.dart';
import '../views/notifications/notifications_view.dart';
import '../views/password/password_view.dart';
import '../views/signup/signup_view.dart';
import '../views/splash/splash_view.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return CupertinoPageRoute(builder: (_) => const SplashView());

      case Routes.login:
        return CupertinoPageRoute(builder: (_) => const LoginView());

      case Routes.signup:
        return CupertinoPageRoute(builder: (_) => const SignupView());

      case Routes.forgotPassword:
        return CupertinoPageRoute(builder: (_) => const PasswordView());

      case Routes.home:
        return CupertinoPageRoute(builder: (_) => const HomeView());

      case Routes.notifications:
        return CupertinoPageRoute(
          builder: (_) => const NotificationsView(),
          fullscreenDialog: true,
          maintainState: true,
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
