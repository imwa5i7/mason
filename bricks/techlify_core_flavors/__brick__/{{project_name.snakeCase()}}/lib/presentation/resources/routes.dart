import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';
import 'package:{{project_name.snakeCase()}}/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splash = "/";
}

final navKey = GlobalKey<NavigatorState>();

class RouteGenerator {
  static Route<dynamic> getRoute(
    RouteSettings routeSettings,
  ) {
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(Strings.noRouteFound),
              ),
              body: const Center(child: Text(Strings.noRouteFound)),
            ));
  }
}
