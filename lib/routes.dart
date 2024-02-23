import 'package:dog_app/features/primary.dart';
import 'package:dog_app/features/splash.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => const SplashView());
      case '/primary':
        return CupertinoPageRoute(builder: (_) => const PrimaryPage());
      default:
        return CupertinoPageRoute(builder: (_) => Container());
    }
  }
}
