import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessSheet extends StatelessWidget {
  const SuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Check your email !', style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 28
            )),
      
          const Gap(size: 16),
          Text(
            'We have sent a password recover instructions to your email.', style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: const Color(0xFF797272)
            )),
        
          const Gap(size: 45),
        
          ElevatedButton(
            onPressed: ()=>Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false),
            child: const Text('Login')
          ),
        ],
      ),
    );
  }
}