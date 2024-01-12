import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/password_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text(
            'Reset Password', style: Theme.of(context).textTheme.titleMedium),
          'Please choose your new password'.btext(context),

          const Gap(size: 20),

          PasswordField(
            label: 'Password',
            controller: TextEditingController(),
            prefixIcon: AntIcons.lockOutlined,    
          ),

          const Gap(size: 20),

          PasswordField(
            label: 'Confirm Password',
            controller: TextEditingController(),
            prefixIcon: AntIcons.lockOutlined,  
            showIndicator: false  
          ),

          const Gap(size: 32),

          ElevatedButton(
            onPressed: (){}, 
            child: const Text('Reset Password')
          )
        ],
      ),
    );
  }
}