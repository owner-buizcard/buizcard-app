import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/widgets/divider_text.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field.dart';
import 'package:bizcard_app/pages/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text(
            'Login', style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 28
            )),

          const Gap(size: 20),
          
          const InputField(
            label: 'Email Address',
            prefixIcon: AntIcons.mailOutlined,  
          ),

          const Gap(size: 20),

          const InputField(
            label: 'Password',
            prefixIcon: AntIcons.lockOutlined,    
          ),

          const Gap(size: 10),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: (){}, 
              child: const Text('Forgot Password ?')
            ),
          ),

          const Gap(size: 10),

          ElevatedButton(
            onPressed: (){}, 
            child: const Text('Login')
          ),

          const Gap(size: 20),

          const DividerText(text: 'Or Signin With'),

          const Gap(size: 20),

          SocialLogin(
            onClick: ()=>{},
          )
        ],
      ),
    );
  }
}