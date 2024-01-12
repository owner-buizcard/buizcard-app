import 'package:bizcard_app/pages/authentication/callback/callback_view.dart';
import 'package:bizcard_app/pages/authentication/login/login_view.dart';
import 'package:bizcard_app/pages/authentication/password/forgot/forgot_password_view.dart';
import 'package:bizcard_app/pages/authentication/password/reset/reset_password_view.dart';
import 'package:bizcard_app/pages/authentication/signup/cubit/page_cubit.dart';
import 'package:bizcard_app/pages/authentication/photo/photo_view.dart';
import 'package:bizcard_app/pages/authentication/signup/signup_view.dart';
import 'package:bizcard_app/pages/authentication/welcome/welcome_view.dart';
import 'package:bizcard_app/pages/cards/builder/card_builder_view.dart';
import 'package:bizcard_app/pages/cards/links/link_store_view.dart';
import 'package:bizcard_app/pages/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/authentication/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  Routes._();

  //welcome
  static const String splash = "/";
  static const String welcome = "/welcome";

  //welcome
  static const String photo = "/photo";
  static const String forgotPassword = "/forgot-password";
  static const String resetPassword = "/reset-password";
  static const String authCallback = "/auth-callback";
  static const String login = "/login";
  static const String signup = "/signup";

  //cards
  static const String cardBuilder = "/card-builder";
  static const String linkStore = "/link-store";

}

class RouteGenerator {
  final RouteSettings settings;

  RouteGenerator({required this.settings});

  Route<dynamic> getRoute() {
    switch (settings.name) {
      case Routes.splash:
        return getTransistionPage(const SplashView());

      case Routes.welcome:
        return getTransistionPage(const WelcomeView());

      case Routes.signup:
        return getTransistionPage(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(),
            ),
            BlocProvider(
              create: (context) => PageCubit(),
            ),
          ],
          child: const SignupView(),
        ));

      case Routes.login:
        return getTransistionPage(BlocProvider(
          create: (context) => AuthBloc(),
          child: const LoginView(),
        ));

      case Routes.photo:
        return getTransistionPage(BlocProvider(
          create: (context) => AuthBloc(),
          child: const PhotoView(),
        ));

      case Routes.forgotPassword:
        return getTransistionPage(BlocProvider(
          create: (context) => AuthBloc(),
          child: const ForgotPasswordView(),
        ));

      case Routes.resetPassword:
        return getTransistionPage(BlocProvider(
          create: (context) => AuthBloc(),
          child: const ResetPasswordView(),
        ));

      case Routes.authCallback:
        return getTransistionPage(BlocProvider(
          create: (context) => AuthBloc(),
          child: const CallbackView(),
        ));

      case Routes.cardBuilder:
        return getTransistionPage(BlocProvider(
          create: (context) => AuthBloc(),
          child: const CardBuilderView(),
        ));
      
      case Routes.linkStore:
        return getTransistionPage(BlocProvider(
          create: (context) => AuthBloc(),
          child: const LinkStoreView(),
        ));

      default:
        return unDefinedRoute();
    }
  }

  getTransistionPage(Widget child) {
    return PageTransition(
      child: child,
      settings: settings,
      type: PageTransitionType.fade,
    );
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Not Found'),
        ),
      ),
    );
  }
}
