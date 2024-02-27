import 'package:bizcard_app/components/styled_button.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:flutter/material.dart';

class SuccessSheet extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onClick;
  const SuccessSheet({super.key, required this.content, required this.onClick, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, style: Theme.of(context).textTheme.titleMedium),
      
          const Gap(size: 16),
          Text(
            content, style: Theme.of(context).textTheme.labelSmall,),
        
          const Gap(size: 45),
        
          SizedBox(
            width: double.infinity,
            child: StyledButton(
              onPressed: onClick,
              text: 'Login'
            ),
          ),
        ],
      ),
    );
  }
}