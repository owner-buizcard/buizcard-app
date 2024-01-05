import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            'Reset Password', style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 28
            )),
          Text(
            'Please choose your new password', style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: const Color(0xFFB0B0B0)
            )),

          const Gap(size: 20),

          const PasswordField(
            label: 'Password',
            prefixIcon: AntIcons.lockOutlined,    
          ),

          const Gap(size: 20),

          const PasswordField(
            label: 'Confirm Password',
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