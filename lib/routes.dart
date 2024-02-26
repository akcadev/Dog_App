import 'package:dog_app/presentation/pages/primary/primary.dart';
import 'package:dog_app/presentation/splash.dart';
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
