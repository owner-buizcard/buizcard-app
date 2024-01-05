import 'package:bizcard_app/pages/authentication/callback/callback_view.dart';
import 'package:bizcard_app/pages/authentication/login/login_view.dart';
import 'package:bizcard_app/pages/authentication/password/forgot/forgot_password_view.dart';
import 'package:bizcard_app/pages/authentication/password/reset/reset_password_view.dart';
import 'package:bizcard_app/pages/authentication/signup/company/company_view.dart';
import 'package:bizcard_app/pages/authentication/signup/contact/contact_view.dart';
import 'package:bizcard_app/pages/authentication/signup/create/create_view.dart';
import 'package:bizcard_app/pages/authentication/signup/name/name_view.dart';
import 'package:bizcard_app/pages/authentication/signup/photo/photo_view.dart';
import 'package:bizcard_app/pages/authentication/welcome/welcome_view.dart';
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
  static const String name = "/name";
  static const String companyInfo = "/company-info";
  static const String contactInfo = "/contact-info";
  static const String photo = "/photo";
  static const String create = "/create";
  static const String forgotPassword = "/forgot-password";
  static const String resetPassword = "/reset-password";
  static const String authCallback = "/auth-callback";
  static const String login = "/login";
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

      case Routes.login:
        return getTransistionPage(BlocProvider(
          create: (context) => AuthBloc(),
          child: const LoginView(),
        ));

      case Routes.name:
        return getTransistionPage(BlocProvider(
          create: (context) => AuthBloc(),
          child: const NameView(),
        ));

      case Routes.companyInfo:
        return getTransistionPage(BlocProvider(
          create: (context) => AuthBloc(),
          child: const CompanyView(),
        ));

      case Routes.contactInfo:
        return getTransistionPage(BlocProvider(
          create: (context) => AuthBloc(),
          child: const ContactView(),
        ));

      case Routes.create:
        return getTransistionPage(BlocProvider(
          create: (context) => AuthBloc(),
          child: const CreateView(),
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
