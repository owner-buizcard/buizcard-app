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
            'Password reset success !', style: Theme.of(context).textTheme.titleMedium),
      
          const Gap(size: 16),
          Text(
            'You can login with your new password now.', style: Theme.of(context).textTheme.labelSmall,),
        
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