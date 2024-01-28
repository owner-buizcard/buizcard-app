import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() {
    return _instance;
  }

  NavigationService._internal();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  // Push a new screen onto the navigation stack
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  // Pop the current screen from the navigation stack
  void goBack() {
    _navigatorKey.currentState!.pop();
  }

  // Replace the current screen with a new one
  Future<dynamic> replaceWith(String routeName, {dynamic arguments}) {
    return _navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  // Clear the entire navigation stack and navigate to a new screen
  Future<dynamic> navigateAndClear(String routeName, {dynamic arguments}) {
    return _navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }
}
