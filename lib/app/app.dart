import 'package:bizcard_app/constants/theme_const.dart';
import 'package:bizcard_app/network/deep_link_service.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../network/navigation_service.dart';

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    deepLinkService(context);
    return getMaterialApp('Cardbuk', context);
  }

  final NavigationService _navigationService = NavigationService();

  getMaterialApp(String title, BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorKey: _navigationService.navigatorKey,
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      onGenerateRoute: (s) => RouteGenerator(settings: s).getRoute(),
      theme: ThemeConst.getApplicationTheme(),
    );
  }
}