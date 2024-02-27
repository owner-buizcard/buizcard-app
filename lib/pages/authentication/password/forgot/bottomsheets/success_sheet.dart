import 'package:bizcard_app/components/styled_button.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

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
            'Check your email !', style: Theme.of(context).textTheme.titleMedium),
      
          const Gap(size: 16),
          Text(
            'We have sent a password recover instructions to your email.', style: Theme.of(context).textTheme.labelSmall,),
        
          const Gap(size: 45),
        
          SizedBox(
            width: double.infinity,
            child: StyledButton(
              onPressed: ()=>Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false),
              text: 'Login'
            ),
          ),
        ],
      ),
    );
  }
}