import 'package:flutter/material.dart';
import 'package:weatherapps/presentation/screens/weather_home_screen/favorite_screen.dart';
import 'package:weatherapps/presentation/screens/weather_home_screen/weather_home_screen.dart';

class WeatherRoutes {
  static const String homePageRoute = '/home';
  static const String savedCitiesRoute = '/cities';
  static const String favoriteRoute = '/favorite';
}

class RouteGenerator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case WeatherRoutes.homePageRoute:
        return MaterialPageRoute(builder: (_) => const WeatherHomeScreen());
      case WeatherRoutes.favoriteRoute:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
      default:
        return unDefinedRoute();
    }
  }

  /// route is not found show error
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('404'),
              ),
              body: const Center(
                child: Text('Not Found'),
              ),
            ));
  }
}
