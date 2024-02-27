import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/components/styled_button.dart';
import 'package:bizcard_app/pages/widgets/divider_text.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:bizcard_app/pages/widgets/password_field.dart';
import 'package:bizcard_app/pages/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/page_cubit.dart';
import '../signup_viewmodel.dart';

class CreateFragment extends StatelessWidget {
  final SignupViewModel viewModel;
  const CreateFragment(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val){
        context.read<PageCubit>().onPageChange(2);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            Text(
              'Create your account', style: Theme.of(context).textTheme.titleMedium),
      
            const Gap(size: 20),
            
            InputFieldWL(
              label: 'Email Address',
              controller: viewModel.emailController,
              prefixIcon: AntIcons.mailOutlined, 
              isRequired: true,
              validationType: 'email', 
            ),
      
            const Gap(size: 20),
      
            PasswordField(
              label: 'Password',
              controller: viewModel.passwordController,
              prefixIcon: AntIcons.lockOutlined
            ),
      
            const Gap(size: 32),
      
            StyledButton(
              onPressed: ()=>viewModel.onSignupClick(context),
              text: 'Continue'
            ),
      
            const Gap(size: 20),
            const DividerText(text: 'Or SignUp With'),
            const Gap(size: 20),
            const SocialLogin()
          ],
        ),
      ),
    );
  }
}