import 'package:flutter/material.dart';
import 'package:tawsela_app/view/screens/home_page/home_page.dart';

class RouteGenerator {
  static const String home = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      default:
        throw const FormatException('Route not found');
    }
  }
}