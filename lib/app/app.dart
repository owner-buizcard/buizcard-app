import 'package:bizcard_app/constants/theme_const.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return getMaterialApp('Cardbuk', context);
  }

  getMaterialApp(String title, BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
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