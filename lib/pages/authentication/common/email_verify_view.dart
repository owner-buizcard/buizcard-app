import 'package:bizcard_app/constants/assets_const.dart';
import 'package:bizcard_app/pages/authentication/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_routes.dart';

class EmailVerifyView extends StatefulWidget {
  final String callbackUrl;
  const EmailVerifyView({super.key, required this.callbackUrl});

  @override
  State<EmailVerifyView> createState() => _EmailVerifyViewState();
}

class _EmailVerifyViewState extends State<EmailVerifyView> {
  @override
  void initState() {
    context.read<AuthBloc>().add(SocialLoginEvent(link: widget.callbackUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is Success){
          Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsConst.thumbp),
              const Text('Verifying Email ...')
            ],
          ),
        ),
      ),
    );
  }
}
