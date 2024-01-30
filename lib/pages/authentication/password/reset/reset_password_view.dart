import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/authentication/password/reset/reset_password_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';

class ResetPasswordView extends StatefulWidget {
  final String resetLink;
  const ResetPasswordView({super.key, required this.resetLink});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late ResetPasswordViewModel _viewModel;

  @override
  void initState() {
    _viewModel = ResetPasswordViewModel(widget.resetLink);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is Success){
            _viewModel.successSheet(context);
          }
        },
        child: Form(
          key: _viewModel.formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              Text('Reset Password',
                  style: Theme.of(context).textTheme.titleMedium),
              'Please choose your new password'.btext(context),
              const Gap(size: 20),
              PasswordField(
                label: 'Password',
                controller: _viewModel.passwordController,
                prefixIcon: AntIcons.lockOutlined,
              ),
              const Gap(size: 20),
              PasswordField(
                  label: 'Confirm Password',
                  controller: _viewModel.confirmController,
                  prefixIcon: AntIcons.lockOutlined,
                  showIndicator: false),
              const Gap(size: 32),
              ElevatedButton(
                  onPressed: () => _viewModel.onResetClick(context),
                  child: const Text('Reset Password'))
            ],
          ),
        ),
      ),
    );
  }
}
