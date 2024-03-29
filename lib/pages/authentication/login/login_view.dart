import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/components/styled_button.dart';
import 'package:bizcard_app/pages/authentication/login/login_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/divider_text.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:bizcard_app/pages/widgets/password_field.dart';
import 'package:bizcard_app/pages/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_routes.dart';
import '../bloc/auth_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = LoginViewModel();
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
        appBar: AppBar(),
        body: Form(
          key: _viewModel.formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              Text('Login', style: Theme.of(context).textTheme.titleMedium),
              const Gap(size: 20),
              InputFieldWL(
                label: 'Email Address',
                controller: _viewModel.emailController,
                prefixIcon: AntIcons.mailOutlined,
                isRequired: true,
                validationType: 'email'
              ),      
              const Gap(size: 20),
              PasswordField(
                label: 'Password',
                controller: _viewModel.passwordController,
                prefixIcon: AntIcons.lockOutlined,
                showIndicator: false
              ),
              const Gap(size: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.forgotPassword),
                    child: const Text('Forgot Password ?')),
              ),
              const Gap(size: 10),
              StyledButton(
                onPressed: ()=>_viewModel.onLoginClick(context), 
                text: 'Login'
              ),
              const Gap(size: 20),
              const DividerText(text: 'Or Signin With'),
              const Gap(size: 20),
              const SocialLogin()
            ],
          ),
        ),
      ),
    );
  }
}
