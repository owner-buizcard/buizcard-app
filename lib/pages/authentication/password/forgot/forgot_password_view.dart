import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/authentication/password/forgot/forgot_password_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/auth_bloc.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late ForgotPasswordViewModel _viewModel;

  @override
  void initState() {
    _viewModel = ForgotPasswordViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print(state);
          if(state is Success){
            _viewModel.successSheet(context);
          }
        },
        child: Form(
          key: _viewModel.formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              Text('Forgot Password?', style: Theme.of(context).textTheme.titleMedium),
              Text(
                  'You will receive a password reset link via registered email',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color(0xFFB0B0B0))),
              const Gap(size: 20),
              InputFieldWL(
                label: 'Email Address',
                controller: _viewModel.emailController,
                prefixIcon: AntIcons.mailOutlined,
                isRequired: true,
                validationType: 'email',
              ),
              const Gap(size: 32),
              ElevatedButton(
                  onPressed: () => _viewModel.onForgotClick(context),
                  child: const Text('Send Password Reset Email'))
            ],
          ),
        ),
      ),
    );
  }
}
