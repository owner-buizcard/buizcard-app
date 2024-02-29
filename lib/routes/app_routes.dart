import 'package:bizcard_app/constants/urls_const.dart';
import 'package:bizcard_app/models/contact.dart';
import 'package:bizcard_app/models/contact_info.dart';
import 'package:bizcard_app/pages/account/edit/edit_account_view.dart';
import 'package:bizcard_app/pages/authentication/common/callback_view.dart';
import 'package:bizcard_app/pages/authentication/login/login_view.dart';
import 'package:bizcard_app/pages/authentication/password/forgot/forgot_password_view.dart';
import 'package:bizcard_app/pages/authentication/password/reset/reset_password_view.dart';
import 'package:bizcard_app/pages/authentication/signup/cubit/page_cubit.dart';
import 'package:bizcard_app/pages/authentication/common/photo_view.dart';
import 'package:bizcard_app/pages/authentication/signup/signup_view.dart';
import 'package:bizcard_app/pages/authentication/common/welcome_view.dart';
import 'package:bizcard_app/pages/cards/analytics/card_analytics_view.dart';
import 'package:bizcard_app/pages/cards/bloc/card_bloc.dart';
import 'package:bizcard_app/pages/cards/builder/card_builder_view.dart';
import 'package:bizcard_app/pages/cards/links/link_store_view.dart';
import 'package:bizcard_app/pages/common/callback/connect_view.dart';
import 'package:bizcard_app/pages/common/web/launch_view.dart';
import 'package:bizcard_app/pages/contacts/create/create_contact_view.dart';
import 'package:bizcard_app/pages/contacts/extracter/extracter_view.dart';
import 'package:bizcard_app/pages/dashboard/cubit/bottomnav_cubit.dart';
import 'package:bizcard_app/pages/dashboard/dashboard_view.dart';
import 'package:bizcard_app/pages/preview/bizcard_preview.dart';
import 'package:bizcard_app/pages/qrcode/qrcode_theme_view.dart';
import 'package:bizcard_app/pages/scan/scan_view.dart';
import 'package:bizcard_app/pages/settings/analytics/analytics_view.dart';
import 'package:bizcard_app/pages/settings/bloc/settings_bloc.dart';
import 'package:bizcard_app/pages/settings/integrations/integration_view.dart';
import 'package:bizcard_app/pages/settings/settings_view.dart';
import 'package:bizcard_app/pages/splash/splash_view.dart';
import 'package:bizcard_app/subscription/plans/plans_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:showcaseview/showcaseview.dart';

import '../pages/account/bloc/account_bloc.dart';
import '../pages/authentication/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/common/image/image_bloc.dart';
import '../pages/common/open_ai/ai_bloc.dart';
import '../pages/contacts/bloc/contacts_bloc.dart';

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

  static const String zohoCallback = "/i/zoho/callback";

  //dashboard
  static const String home = "/home";
  static const String settings = "/settings";
  static const String scan = "/scan";

  //contacts
  static const String extracter = "/extracter";
  static const String createContact = "/create-contact";
  static const String editContact = "/edit-contact";

  //cards
  static const String cardBuilder = "/card-builder";
  static const String cardAnalytics = "/card/analytics";
  static const String qrTheme = "/qr-theme";
  static const String linkStore = "/link-store";
  static const String preview = "/preview";

  //settings
  static const String integrations = "/integrations";
  static const String callback = "/callback";
  static const String analytics = "/analytics";

  //account
  static const String editAccount = "/account-edit";
  static const String plans = "/plans";

  //other
  static const String launchView = "/launch-view";
}

class RouteGenerator {
  final RouteSettings settings;

  RouteGenerator({required this.settings});

  Route<dynamic> getRoute() {
    String routeName = settings.name ?? "";
    var link = '${UrlsConst.domain}$routeName';

    if (routeName.contains("i/callback/")) {
      return getTransistionPage(BlocProvider(
        create: (context) => SettingsBloc(),
        child: ConnectView(url: link),
      ));
    } else if (routeName.contains("auth/callback")) {
      return getTransistionPage(BlocProvider(
        create: (context) => AuthBloc(),
        child: CallbackView(callbackUrl: link),
      ));
    } else if (routeName.contains("password/reset")) {
      return getTransistionPage(BlocProvider(
        create: (context) => AuthBloc(),
        child: ResetPasswordView(resetLink: link),
      ));
    }

    switch (routeName) {
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
        return getTransistionPage(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(),
            ),
            BlocProvider(
              create: (context) => ImageBloc(),
            ),
          ],
          child: const PhotoView(),
        ));

      case Routes.forgotPassword:
        return getTransistionPage(BlocProvider(
          create: (context) => AuthBloc(),
          child: const ForgotPasswordView(),
        ));

      case Routes.analytics:
        return getTransistionPage(BlocProvider(
          create: (context) => SettingsBloc()..add(GetMyAnalyticsEvent()),
          child: const AnalyticsView(),
        ));

      case Routes.cardAnalytics:
        var cardId = settings.arguments as String;
        return getTransistionPage(BlocProvider(
          create: (context) => CardBloc(),
          child: CardAnalyticsView(cardId: cardId),
        ));

      case Routes.cardBuilder:
        return getTransistionPage(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CardBloc(),
            ),
            BlocProvider(
              create: (context) => ImageBloc(),
            ),
          ],
          child: CardBuilderView(cardId: settings.arguments as String),
        ));

      case Routes.linkStore:
        return getTransistionPage(BlocProvider(
          create: (context) => CardBloc(),
          child: LinkStoreView(
            cardId: settings.arguments as String,
          ),
        ));

      case Routes.home:
        return getTransistionPage(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HomePageCubit(),
            ),
            BlocProvider(
              create: (context) => CardBloc(),
            ),
            BlocProvider(
              create: (context) => ContactsBloc(),
            ),
          ],
          child: ShowCaseWidget(
              builder: Builder(builder: (_) => const DashboardView())),
        ));

      case Routes.settings:
        return getTransistionPage(BlocProvider(
          create: (context) => SettingsBloc(),
          child: const SettingsView(),
        ));

      case Routes.launchView:
        return getTransistionPage(
            LaunchView(url: settings.arguments as String));

      case Routes.integrations:
        return getTransistionPage(BlocProvider(
          create: (context) => AccountBloc(),
          child: const IntegrationView(),
        ));

      case Routes.plans:
        return getTransistionPage(BlocProvider(
          create: (context) => AccountBloc(),
          child: const PlansView(),
        ));

      case Routes.editAccount:
        return getTransistionPage(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AccountBloc(),
            ),
            BlocProvider(
              create: (context) => ImageBloc(),
            ),
          ],
          child: const EditAccountView(),
        ));

      case Routes.callback:
        return getTransistionPage(BlocProvider(
          create: (context) => SettingsBloc(),
          child: ConnectView(url: settings.arguments as String),
        ));

      case Routes.scan:
        return getTransistionPage(const ScanView());

      case Routes.zohoCallback:
        return getTransistionPage(const ScanView());

      case Routes.qrTheme:
        return getTransistionPage(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CardBloc(),
            ),
            BlocProvider(
              create: (context) => ImageBloc(),
            ),
          ],
          child: QrcodeThemeView(cardId: settings.arguments as String),
        ));

      case Routes.createContact:
        return getTransistionPage(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ImageBloc(),
            ),
            BlocProvider(
              create: (context) => ContactsBloc(),
            ),
          ],
          child: CreateContactView(info: settings.arguments as ContactInfo?),
        ));

      case Routes.editContact:
        return getTransistionPage(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ImageBloc(),
            ),
            BlocProvider(
              create: (context) => ContactsBloc(),
            ),
          ],
          child: CreateContactView(contact: settings.arguments as Contact?),
        ));

      case Routes.extracter:
        return getTransistionPage(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ContactsBloc(),
            ),
            BlocProvider(
              create: (context) => AiBloc()
                ..add(
                    ExtractContactEvent(content: settings.arguments as String)),
            ),
          ],
          child: ExtracterView(text: settings.arguments as String),
        ));

      case Routes.preview:
        var cardId = settings.arguments as String;
        return getTransistionPage(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CardBloc()..add(GetCardDetails(cardId)),
            ),
            BlocProvider(
              create: (context) => ContactsBloc(),
            ),
          ],
          child: BizcardPreview(cardId: cardId),
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
